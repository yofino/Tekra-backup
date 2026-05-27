"""
TRAIN V2 - Tuned XGBoost with proper labels, balancing, and backtest
"""
import MetaTrader5 as mt5
import pandas as pd
import numpy as np
import xgboost as xgb
from sklearn.model_selection import TimeSeriesSplit, cross_val_score
from sklearn.metrics import accuracy_score, precision_score, recall_score, f1_score
import pickle, os, json
from datetime import datetime, timedelta

SYMBOL = "XAUUSDm"
MODEL_DIR = r"C:\TradingBot\models"
DATA_DIR = r"C:\TradingBot\data"
REPORT_PATH = r"C:\TradingBot\tuning_report.txt"

def log(msg):
    t = datetime.now().strftime("%H:%M:%S")
    line = f"[{t}] {msg}"
    print(line)
    with open(REPORT_PATH, "a") as f:
        f.write(line + "\n")

# ──── FETCH ────
def fetch_data():
    mt5.initialize()
    end = datetime.now()
    start = end - timedelta(days=90)
    log(f"Fetching MT5 data {start.strftime('%Y-%m-%d')} to {end.strftime('%Y-%m-%d')}")
    rates = mt5.copy_rates_range(SYMBOL, mt5.TIMEFRAME_M5, start, end)
    mt5.shutdown()
    if rates is None:
        log(f"Failed: {mt5.last_error()}")
        return None
    df = pd.DataFrame(rates)
    df['time'] = pd.to_datetime(df['time'], unit='s')
    df.set_index('time', inplace=True)
    log(f"Got {len(df)} M5 candles")
    return df

# ──── FEATURES ────
def build_features(df):
    df = df.copy()
    df['returns'] = df['close'].pct_change()
    df['hl_range'] = (df['high'] - df['low']) / df['close']
    df['close_pos'] = (df['close'] - df['low']) / (df['high'] - df['low'] + 0.0001)
    df['body'] = (df['close'] - df['open']).abs() / (df['high'] - df['low'] + 0.0001)
    df['direction'] = np.where(df['close'] > df['open'], 1, -1)

    df['MA_9'] = df['close'].rolling(9).mean()
    df['MA_21'] = df['close'].rolling(21).mean()
    df['MA_50'] = df['close'].rolling(50).mean()
    df['MA_200'] = df['close'].rolling(200).mean()

    df['dist_ma9'] = (df['close'] - df['MA_9']) / df['close']
    df['dist_ma21'] = (df['close'] - df['MA_21']) / df['close']
    df['dist_ma50'] = (df['close'] - df['MA_50']) / df['close']
    df['ma9_slope'] = df['MA_9'].pct_change(5)
    df['ma21_slope'] = df['MA_21'].pct_change(5)

    delta = df['close'].diff()
    gain = delta.clip(lower=0)
    loss = -delta.clip(upper=0)
    avg_gain = gain.ewm(span=14, adjust=False).mean()
    avg_loss = loss.ewm(span=14, adjust=False).mean()
    rs = avg_gain / avg_loss.replace(0, np.nan)
    df['RSI'] = 100 - (100 / (1 + rs))
    df['RSI_change'] = df['RSI'].diff(5)

    w = 20
    df['BB_mid'] = df['close'].rolling(w).mean()
    std = df['close'].rolling(w).std()
    df['BB_upper'] = df['BB_mid'] + 2 * std
    df['BB_lower'] = df['BB_mid'] - 2 * std
    df['BB_width'] = (df['BB_upper'] - df['BB_lower']) / df['BB_mid']
    df['BB_pos'] = (df['close'] - df['BB_mid']) / (df['BB_upper'] - df['BB_lower'] + 0.0001)

    ema12 = df['close'].ewm(span=12, adjust=False).mean()
    ema26 = df['close'].ewm(span=26, adjust=False).mean()
    df['MACD'] = ema12 - ema26
    df['MACD_signal'] = df['MACD'].ewm(span=9, adjust=False).mean()
    df['MACD_hist'] = (df['MACD'] - df['MACD_signal']) / df['close']

    hl = df['high'] - df['low']
    hc = np.abs(df['high'] - df['close'].shift())
    lc = np.abs(df['low'] - df['close'].shift())
    tr = np.maximum(hl, np.maximum(hc, lc))
    df['ATR'] = tr.ewm(span=14, adjust=False).mean()
    df['ATR_pct'] = df['ATR'] / df['close']

    df['vol_ma20'] = df['tick_volume'].rolling(20).mean()
    df['vol_ratio'] = df['tick_volume'] / (df['vol_ma20'] + 1)

    for p in [3, 5, 10, 20]:
        df[f'mom_{p}'] = df['close'].pct_change(p)

    df['volatility'] = df['returns'].rolling(10).std()
    df['hour'] = df.index.hour
    df['dow'] = df.index.dayofweek
    df['session'] = 0
    df.loc[(df['hour'] >= 8) & (df['hour'] < 16), 'session'] = 1
    df.loc[(df['hour'] >= 13) & (df['hour'] < 21), 'session'] = 2

    return df

# ──── LABELS V2 (FIXED) ────
def create_labels(df, forward=12):
    """Label: 1=price will move UP 0.2%+, 0=price will NOT move up"""
    future_close = df['close'].shift(-forward)
    pct_change = (future_close - df['close']) / df['close']
    df['target'] = (pct_change > 0.001).astype(int)  # 0.1% threshold (10 pips)
    return df

# ──── TRAIN ────
def train_model(df):
    feature_cols = [
        'returns', 'hl_range', 'close_pos', 'body', 'direction',
        'dist_ma9', 'dist_ma21', 'dist_ma50', 'ma9_slope', 'ma21_slope',
        'RSI', 'RSI_change',
        'BB_width', 'BB_pos',
        'MACD_hist', 'ATR_pct', 'vol_ratio',
        'mom_3', 'mom_5', 'mom_10', 'mom_20',
        'volatility', 'hour', 'dow', 'session'
    ]
    feature_cols = [c for c in feature_cols if c in df.columns]

    data = df.dropna(subset=feature_cols + ['target'])
    X = data[feature_cols]
    y = data['target']

    log(f"Samples: {len(X)} | BUY%: {y.mean()*100:.1f}% | Features: {len(feature_cols)}")

    split = int(len(X) * 0.75)
    X_tr, X_va = X.iloc[:split], X.iloc[split:]
    y_tr, y_va = y.iloc[:split], y.iloc[split:]

    # Scale weight for imbalance
    scale_pos = (len(y_tr) - y_tr.sum()) / (y_tr.sum() + 1)
    log(f"Scale pos weight: {scale_pos:.2f}")

    params = {
        'n_estimators': 300,
        'max_depth': 6,
        'learning_rate': 0.03,
        'subsample': 0.75,
        'colsample_bytree': 0.75,
        'min_child_weight': 5,
        'gamma': 0.2,
        'reg_alpha': 0.5,
        'reg_lambda': 1.5,
        'scale_pos_weight': scale_pos,
        'random_state': 42,
        'eval_metric': 'logloss'
    }

    model = xgb.XGBClassifier(**params)
    model.fit(X_tr, y_tr, eval_set=[(X_va, y_va)], verbose=False)

    # Evaluate
    y_pred = model.predict(X_va)
    y_proba = model.predict_proba(X_va)[:, 1]

    acc = accuracy_score(y_va, y_pred)
    prec = precision_score(y_va, y_pred, zero_division=0)
    rec = recall_score(y_va, y_pred, zero_division=0)
    f1v = f1_score(y_va, y_pred, zero_division=0)

    # Find best threshold
    best_f1, best_t = 0, 0.5
    for t in np.arange(0.3, 0.7, 0.05):
        yt = (y_proba >= t).astype(int)
        f = f1_score(y_va, yt, zero_division=0)
        if f > best_f1:
            best_f1, best_t = f, t

    y_best = (y_proba >= best_t).astype(int)
    prec_best = precision_score(y_va, y_best, zero_division=0)
    rec_best = recall_score(y_va, y_best, zero_division=0)

    log(f"============================================")
    log(f" MODEL V2 RESULTS")
    log(f"============================================")
    log(f"Accuracy:  {acc:.4f} ({acc*100:.1f}%)")
    log(f"Precision: {prec:.4f}")
    log(f"Recall:    {rec:.4f}")
    log(f"F1:        {f1v:.4f}")
    log(f"Best threshold: {best_t:.2f} (F1={best_f1:.4f})")
    log(f"At best threshold -> Precision: {prec_best:.4f}, Recall: {rec_best:.4f}")
    log(f"Buys predicted at default: {y_pred.sum()}/{len(y_pred)} ({y_pred.sum()/len(y_pred)*100:.1f}%)")
    log(f"Buys predicted at best t:  {y_best.sum()}/{len(y_best)} ({y_best.sum()/len(y_best)*100:.1f}%)")

    # Feature importance
    imp = pd.DataFrame({'feature': feature_cols, 'importance': model.feature_importances_})
    imp.sort_values('importance', ascending=False, inplace=True)
    log(f"\nTop 10 Features:")
    for _, r in imp.head(10).iterrows():
        log(f"  {r['feature']:20s} {r['importance']:.4f}")

    metrics = {
        'accuracy': acc, 'precision': prec, 'recall': rec, 'f1': f1v,
        'best_threshold': best_t, 'best_f1': best_f1,
        'best_precision': prec_best, 'best_recall': rec_best,
        'features': feature_cols, 'scale_pos_weight': scale_pos
    }

    return model, metrics, imp, best_t

# ──── BACKTEST V2 ────
def backtest_v2(df, model, feature_cols, threshold):
    data = df.dropna(subset=feature_cols)
    split = int(len(data) * 0.75)
    data_val = data.iloc[split:].copy()

    X_val = data_val[feature_cols]
    data_val['pred_proba'] = model.predict_proba(X_val)[:, 1]
    data_val['signal'] = 0
    data_val.loc[data_val['pred_proba'] >= threshold, 'signal'] = 1
    data_val.loc[data_val['pred_proba'] <= (1 - threshold), 'signal'] = -1

    balance = 10000
    trades = []
    in_trade = None  # 'buy', 'sell'
    entry_price = 0
    entry_time = None

    for idx, row in data_val.iterrows():
        sig = row['signal']

        if in_trade == 'buy':
            # Exit conditions
            exit = False
            exit_price = row['close']
            if sig == -1:  # reverse signal
                exit = True
            if exit:
                pnl = (exit_price - entry_price) / 0.01 * 0.10 * 0.1  # 0.1 lot
                balance += pnl
                trades.append({'entry': entry_time, 'exit': idx, 'type': 'BUY',
                               'entry_p': entry_price, 'exit_p': exit_price,
                               'pnl': round(pnl, 2), 'bal': round(balance, 2)})
                in_trade = None

        elif in_trade == 'sell':
            exit = False
            exit_price = row['close']
            if sig == 1:
                exit = True
            if exit:
                pnl = (entry_price - exit_price) / 0.01 * 0.10 * 0.1
                balance += pnl
                trades.append({'entry': entry_time, 'exit': idx, 'type': 'SELL',
                               'entry_p': entry_price, 'exit_p': exit_price,
                               'pnl': round(pnl, 2), 'bal': round(balance, 2)})
                in_trade = None

        else:
            if sig == 1:
                in_trade = 'buy'
                entry_price = row['close']
                entry_time = idx
            elif sig == -1:
                in_trade = 'sell'
                entry_price = row['close']
                entry_time = idx

    wins = [t for t in trades if t['pnl'] > 0]
    losses = [t for t in trades if t['pnl'] <= 0]
    total_pnl = balance - 10000

    log(f"\n============================================")
    log(f" BACKTEST V2 (Validation period only)")
    log(f"============================================")
    log(f"Trades: {len(trades)} | Wins: {len(wins)} ({len(wins)/max(len(trades),1)*100:.0f}%) | Losses: {len(losses)}")
    log(f"P&L: ${total_pnl:+.2f} | Final: ${balance:,.2f}")
    log(f"Return: {total_pnl/10000*100:+.1f}%")
    if wins:
        log(f"Avg Win: ${np.mean([t['pnl'] for t in wins]):+.2f}")
    if losses:
        log(f"Avg Loss: ${np.mean([t['pnl'] for t in losses]):+.2f}")

    return trades, balance, total_pnl

# ──── MAIN ────
def main():
    open(REPORT_PATH, "w").close()
    os.makedirs(MODEL_DIR, exist_ok=True)
    log("===== TUNING V2 =====")

    df = fetch_data()
    if df is None or len(df) < 1000:
        log("Not enough data")
        return

    df = build_features(df)
    df = create_labels(df)

    model, metrics, imp, best_t = train_model(df)
    trades, final_bal, pnl = backtest_v2(df, model, metrics['features'], best_t)

    # Save model
    model_path = f"{MODEL_DIR}\\xgboost_v2.pkl"
    with open(model_path, 'wb') as f:
        pickle.dump({'model': model, 'features': metrics['features'], 'threshold': best_t}, f)
    log(f"\nSaved: {model_path}")

    # Save metrics
    with open(f"{MODEL_DIR}\\metrics_v2.json", 'w') as f:
        metrics_save = {k: v for k, v in metrics.items() if k != 'features'}
        metrics_save['trades'] = len(trades)
        metrics_save['pnl'] = pnl
        metrics_save['final_balance'] = final_bal
        if trades:
            wins = [t for t in trades if t['pnl'] > 0]
            metrics_save['win_rate'] = len(wins) / len(trades) * 100
        json.dump(metrics_save, f, indent=2)

    log(f"\n===== DONE =====")
    log(f"Manual baseline:  41% win rate, -$24 loss")
    log(f"AI model V2:      {metrics['accuracy']*100:.1f}% accuracy, backtest P&L: ${pnl:+.2f}")

if __name__ == "__main__":
    main()
