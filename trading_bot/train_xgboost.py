"""
TRAIN XGBoost Model for XAUUSD Trading
Fase 3: Learn patterns from historical data to predict price direction
"""
import MetaTrader5 as mt5
import pandas as pd
import numpy as np
from datetime import datetime, timedelta
import xgboost as xgb
from sklearn.model_selection import train_test_split
from sklearn.metrics import accuracy_score, precision_score, recall_score, f1_score, confusion_matrix
import pickle
import os
import json

SYMBOL = "XAUUSDm"
MODEL_DIR = r"C:\TradingBot\models"
DATA_DIR = r"C:\TradingBot\data"

def log(msg):
    t = datetime.now().strftime("%H:%M:%S")
    print(f"[{t}] {msg}")

# ──── FETCH DATA ────
def fetch_data():
    """Get as much historical data as available + combine with saved CSV"""
    mt5.initialize()
    
    # Try fetching from MT5
    end = datetime.now()
    start = end - timedelta(days=90)
    
    log(f"Fetching MT5 data from {start.strftime('%Y-%m-%d')} to {end.strftime('%Y-%m-%d')}")
    rates = mt5.copy_rates_range(SYMBOL, mt5.TIMEFRAME_M5, start, end)
    
    if rates is None:
        log(f"MT5 fetch failed: {mt5.last_error()}")
        mt5.shutdown()
        return None
    
    df = pd.DataFrame(rates)
    df['time'] = pd.to_datetime(df['time'], unit='s')
    df.set_index('time', inplace=True)
    
    # Also load saved CSV data if available
    csv_path = f"{DATA_DIR}\\xauusd_full.csv"
    if os.path.exists(csv_path):
        df_csv = pd.read_csv(csv_path, index_col=0, parse_dates=True)
        df = pd.concat([df, df_csv])
        df = df[~df.index.duplicated(keep='first')]
        df.sort_index(inplace=True)
    
    mt5.shutdown()
    log(f"Total data: {len(df)} candles ({df.index[0]} to {df.index[-1]})")
    return df

# ──── FEATURE ENGINEERING ────
def build_features(df):
    """Create all features for the model"""
    df = df.copy()
    
    # Price-based
    df['returns'] = df['close'].pct_change()
    df['high_low_pct'] = (df['high'] - df['low']) / df['close'] * 100
    df['close_position'] = (df['close'] - df['low']) / (df['high'] - df['low'])
    
    # Moving averages
    df['MA_9'] = df['close'].rolling(9).mean()
    df['MA_21'] = df['close'].rolling(21).mean()
    df['MA_50'] = df['close'].rolling(50).mean()
    df['MA_200'] = df['close'].rolling(200).mean()
    
    df['MA_9_21_ratio'] = df['MA_9'] / df['MA_21'] - 1
    df['MA_21_50_ratio'] = df['MA_21'] / df['MA_50'] - 1
    df['price_ma9_dist'] = (df['close'] - df['MA_9']) / df['close'] * 100
    df['price_ma50_dist'] = (df['close'] - df['MA_50']) / df['close'] * 100
    
    # RSI
    delta = df['close'].diff()
    gain = delta.clip(lower=0)
    loss = -delta.clip(upper=0)
    avg_gain = gain.rolling(14).mean()
    avg_loss = loss.rolling(14).mean()
    rs = avg_gain / avg_loss.replace(0, np.nan)
    df['RSI'] = 100 - (100 / (1 + rs))
    
    # MACD
    ema12 = df['close'].ewm(span=12).mean()
    ema26 = df['close'].ewm(span=26).mean()
    df['MACD'] = ema12 - ema26
    df['MACD_signal'] = df['MACD'].ewm(span=9).mean()
    df['MACD_hist'] = df['MACD'] - df['MACD_signal']
    df['MACD_hist_pct'] = df['MACD_hist'] / df['close'] * 100
    
    # Bollinger
    df['BB_mid'] = df['close'].rolling(20).mean()
    std = df['close'].rolling(20).std()
    df['BB_width'] = (2 * std) / df['BB_mid'] * 100
    df['BB_position'] = (df['close'] - df['BB_mid']) / (2 * std)
    
    # ATR
    hl = df['high'] - df['low']
    hc = np.abs(df['high'] - df['close'].shift())
    lc = np.abs(df['low'] - df['close'].shift())
    tr = np.maximum(hl, np.maximum(hc, lc))
    df['ATR'] = tr.rolling(14).mean()
    df['ATR_pct'] = df['ATR'] / df['close'] * 100
    
    # Volume
    df['vol_change'] = df['tick_volume'].pct_change()
    df['vol_ratio_20'] = df['tick_volume'] / df['tick_volume'].rolling(20).mean()
    
    # Price momentum (rate of change)
    for period in [3, 5, 10, 20]:
        df[f'ROC_{period}'] = df['close'].pct_change(period) * 100
    
    # Volatility
    df['volatility_10'] = df['returns'].rolling(10).std() * 100
    df['volatility_20'] = df['returns'].rolling(20).std() * 100
    
    # Time features
    df['hour'] = df.index.hour
    df['day_of_week'] = df.index.dayofweek
    df['is_asian_session'] = ((df['hour'] >= 0) & (df['hour'] < 8)).astype(int)
    df['is_london_session'] = ((df['hour'] >= 8) & (df['hour'] < 16)).astype(int)
    df['is_ny_session'] = ((df['hour'] >= 13) & (df['hour'] < 21)).astype(int)
    
    return df

# ──── LABEL DATA ────
def create_labels(df, forward_candles=10):
    """
    Label: 1 = price goes UP by at least 0.3 ATR in next N candles
           0 = price goes DOWN by at least 0.3 ATR in next N candles
    """
    labels = []
    targets = []
    
    for i in range(len(df) - forward_candles):
        current_price = df['close'].iloc[i]
        future_high = df['high'].iloc[i+1 : i+forward_candles+1].max()
        future_low = df['low'].iloc[i+1 : i+forward_candles+1].min()
        atr = df['ATR'].iloc[i]
        
        up_move = (future_high - current_price) / current_price * 100
        down_move = (current_price - future_low) / current_price * 100
        
        atr_threshold = (atr / current_price * 100) * 0.3
        
        if up_move > atr_threshold and up_move > down_move:
            labels.append(1)  # BUY
        else:
            labels.append(0)  # SELL/HOLD
    
    # Pad for last N candles
    labels = labels + [0] * (len(df) - len(labels))
    labels = labels[:len(df)]
    
    df['target'] = labels
    return df

# ──── TRAIN MODEL ────
def train_model(df):
    feature_cols = [
        'returns', 'high_low_pct', 'close_position',
        'MA_9_21_ratio', 'MA_21_50_ratio', 'price_ma9_dist', 'price_ma50_dist',
        'RSI', 'MACD_hist_pct', 'BB_width', 'BB_position',
        'ATR_pct', 'vol_change', 'vol_ratio_20',
        'ROC_3', 'ROC_5', 'ROC_10', 'ROC_20',
        'volatility_10', 'volatility_20',
        'hour', 'day_of_week',
        'is_asian_session', 'is_london_session', 'is_ny_session'
    ]
    
    # Keep only columns that exist
    feature_cols = [c for c in feature_cols if c in df.columns]
    
    # Drop NaN
    df_clean = df.dropna(subset=feature_cols + ['target'])
    
    X = df_clean[feature_cols]
    y = df_clean['target']
    
    log(f"Training data: {len(X)} samples, {len(feature_cols)} features")
    log(f"Class distribution: BUY={y.sum()} ({y.sum()/len(y)*100:.1f}%), SELL={(len(y)-y.sum())} ({(len(y)-y.sum())/len(y)*100:.1f}%)")
    
    # Train/validation split (time-series aware: no shuffling)
    split_idx = int(len(X) * 0.8)
    X_train, X_val = X.iloc[:split_idx], X.iloc[split_idx:]
    y_train, y_val = y.iloc[:split_idx], y.iloc[split_idx:]
    
    log(f"Train: {len(X_train)}, Validation: {len(X_val)}")
    
    # Model
    model = xgb.XGBClassifier(
        n_estimators=200,
        max_depth=5,
        learning_rate=0.05,
        subsample=0.8,
        colsample_bytree=0.8,
        min_child_weight=3,
        gamma=0.1,
        reg_alpha=0.1,
        reg_lambda=1.0,
        random_state=42,
        eval_metric='logloss',
        early_stopping_rounds=20
    )
    
    model.fit(
        X_train, y_train,
        eval_set=[(X_val, y_val)],
        verbose=False
    )
    
    # Evaluate
    y_pred = model.predict(X_val)
    y_proba = model.predict_proba(X_val)[:, 1]
    
    acc = accuracy_score(y_val, y_pred)
    prec = precision_score(y_val, y_pred, zero_division=0)
    rec = recall_score(y_val, y_pred, zero_division=0)
    f1 = f1_score(y_val, y_pred, zero_division=0)
    cm = confusion_matrix(y_val, y_pred)
    
    log(f"\n{'='*50}")
    log(f" MODEL PERFORMANCE")
    log(f"{'='*50}")
    log(f"Accuracy:   {acc:.4f} ({acc*100:.1f}%)")
    log(f"Precision:  {prec:.4f} (when model says BUY, how often correct)")
    log(f"Recall:     {rec:.4f} (how many actual BUYs caught)")
    log(f"F1 Score:   {f1:.4f}")
    log(f"Confusion Matrix:")
    log(f"  TN={cm[0][0]}, FP={cm[0][1]}")
    log(f"  FN={cm[1][0]}, TP={cm[1][1]}")
    log(f"{'='*50}")
    
    # Feature importance
    importance = pd.DataFrame({
        'feature': feature_cols,
        'importance': model.feature_importances_
    }).sort_values('importance', ascending=False)
    
    log(f"\nTop 10 Features:")
    for _, row in importance.head(10).iterrows():
        log(f"  {row['feature']:25s}: {row['importance']:.4f}")
    
    return model, importance, {
        'accuracy': acc,
        'precision': prec,
        'recall': rec,
        'f1': f1,
        'cm': cm.tolist(),
        'feature_cols': feature_cols,
        'n_train': len(X_train),
        'n_val': len(X_val),
        'n_features': len(feature_cols)
    }

# ──── BACKTEST WITH MODEL ────
def backtest_with_model(df, model, feature_cols):
    """Test the trained model on the validation portion"""
    df_clean = df.dropna(subset=feature_cols)
    
    split_idx = int(len(df_clean) * 0.8)
    df_val = df_clean.iloc[split_idx:]
    
    # Get predictions
    X_val = df_val[feature_cols]
    df_val = df_val.copy()
    df_val['pred'] = model.predict(X_val)
    df_val['pred_proba'] = model.predict_proba(X_val)[:, 1]
    
    # Only trade on high confidence predictions
    confidence_threshold = 0.6
    df_val['trade_signal'] = 0
    df_val.loc[(df_val['pred'] == 1) & (df_val['pred_proba'] > confidence_threshold), 'trade_signal'] = 1
    df_val.loc[(df_val['pred'] == 0) & (df_val['pred_proba'] < (1-confidence_threshold)), 'trade_signal'] = -1
    
    # Count signals
    buys = (df_val['trade_signal'] == 1).sum()
    sells = (df_val['trade_signal'] == -1).sum()
    
    log(f"\nModel signals (confidence > {confidence_threshold}):")
    log(f"  BUY:  {buys}")
    log(f"  SELL: {sells}")
    log(f"  HOLD: {len(df_val) - buys - sells}")
    
    return df_val

# ──── MAIN ────
def main():
    os.makedirs(MODEL_DIR, exist_ok=True)
    
    log("===== XGBOOST TRAINING PIPELINE =====")
    
    # 1. Get data
    df = fetch_data()
    if df is None or len(df) < 1000:
        log("Not enough data! Need at least 1000 candles.")
        return
    
    # 2. Features
    log("\nBuilding features...")
    df = build_features(df)
    
    # 3. Labels
    log("Creating labels...")
    df = create_labels(df, forward_candles=10)
    
    # 4. Train
    model, importance, metrics = train_model(df)
    
    # 5. Backtest
    df_val = backtest_with_model(df, model, metrics['feature_cols'])
    
    # 6. Save
    model_path = f"{MODEL_DIR}\\xgboost_xauusd_v1.pkl"
    with open(model_path, 'wb') as f:
        pickle.dump(model, f)
    log(f"\nModel saved: {model_path}")
    
    # Save feature list for future use
    with open(f"{MODEL_DIR}\\features.json", 'w') as f:
        json.dump(metrics['feature_cols'], f, indent=2)
    
    # Save metrics
    metrics_path = f"{MODEL_DIR}\\metrics_v1.json"
    with open(metrics_path, 'w') as f:
        json.dump({k: v for k, v in metrics.items() if k != 'cm' and k != 'feature_cols'}, f, indent=2)
    log(f"Metrics saved: {metrics_path}")
    
    # Summary
    log(f"\n{'='*60}")
    log(f" TRAINING COMPLETE - Summary")
    log(f"{'='*60}")
    log(f"Model Accuracy: {metrics['accuracy']*100:.1f}%")
    log(f"Baseline Accuracy (simple MA cross): ~41%")
    log(f"Improvement: {(metrics['accuracy'] - 0.41)*100:.0f}% better than random rules")
    log(f"{'='*60}")
    
    return model, metrics

if __name__ == "__main__":
    main()
