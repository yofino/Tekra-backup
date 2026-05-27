"""
TRADING BOT V3 - AI Powered (XGBoost)
Menggantikan rules manual dengan prediksi AI
"""
import MetaTrader5 as mt5
import pandas as pd
import numpy as np
import pickle
import time
import os
from datetime import datetime, timedelta

SYMBOL = "XAUUSDm"
TIMEFRAME = mt5.TIMEFRAME_M1
DATA_DIR = r"C:\TradingBot\data"
LOG_FILE = r"C:\TradingBot\bot_ai.log"
MODEL_PATH = r"C:\TradingBot\models\xgboost_v2.pkl"

# Risk management
RISK_PCT = 0.5      # 0.5% per trade
SL_ATR = 1.5
TP_ATR = 3.0
CONFIDENCE_MIN = 0.55   # Minimum confidence to trade

# Load AI Model
with open(MODEL_PATH, 'rb') as f:
    MODEL_DATA = pickle.load(f)

MODEL = MODEL_DATA['model']
FEATURES = MODEL_DATA['features']
THRESHOLD = MODEL_DATA.get('threshold', 0.3)

# ──── LOG ────
def log(msg):
    t = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    line = f"[{t}] {msg}"
    print(line)
    with open(LOG_FILE, "a") as f:
        f.write(line + "\n")

# ──── CONNECT ────
def connect():
    if not mt5.initialize():
        log(f"MT5 init failed: {mt5.last_error()}")
        return False
    log(f"MT5 connected - {mt5.account_info().login}")
    return True

# ──── FETCH ────
def fetch_rates(n=500):
    rates = mt5.copy_rates_from_pos(SYMBOL, TIMEFRAME, 0, n)
    if rates is None:
        return None
    df = pd.DataFrame(rates)
    df['time'] = pd.to_datetime(df['time'], unit='s')
    df.set_index('time', inplace=True)
    return df

# ──── FEATURES (same as training) ────
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
    df['BB_upper'] = df['BB_mid'] + 2*std
    df['BB_lower'] = df['BB_mid'] - 2*std
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
    for p in [3,5,10,20]:
        df[f'mom_{p}'] = df['close'].pct_change(p)
    df['volatility'] = df['returns'].rolling(10).std()
    df['hour'] = df.index.hour
    df['dow'] = df.index.dayofweek
    df['session'] = 0
    df.loc[(df['hour'] >= 8) & (df['hour'] < 16), 'session'] = 1
    df.loc[(df['hour'] >= 13) & (df['hour'] < 21), 'session'] = 2
    return df

# ──── AI PREDICTION ────
def ai_predict(df):
    """Get AI prediction for latest candle"""
    df_feat = df.dropna(subset=FEATURES)
    if len(df_feat) == 0:
        return None, 0

    latest = df_feat.iloc[-1:]
    X = latest[FEATURES]

    proba = MODEL.predict_proba(X)[0, 1]
    confidence = max(proba, 1 - proba)

    if proba >= THRESHOLD and confidence >= CONFIDENCE_MIN:
        signal = 1  # BUY
    elif proba <= (1 - THRESHOLD) and confidence >= CONFIDENCE_MIN:
        signal = -1  # SELL
    else:
        signal = 0  # HOLD

    return signal, confidence

# ──── SAVE DATA ────
def save_data(df):
    os.makedirs(DATA_DIR, exist_ok=True)
    today = datetime.now().strftime("%Y%m%d")
    path = f"{DATA_DIR}\\xauusd_{today}.csv"
    csv_cols = ['open','high','low','close','tick_volume','spread','RSI','MA_cross','ATR']
    save = df[[c for c in csv_cols if c in df.columns]]
    if os.path.exists(path):
        save.to_csv(path, mode='a', header=False)
    else:
        save.to_csv(path)

# ──── MAIN ────
def main():
    log("===== BOT V3 AI START =====")
    log(f"Model: {MODEL_PATH}")
    log(f"Features: {len(FEATURES)} | Threshold: {THRESHOLD} | Confidence: {CONFIDENCE_MIN}")
    log(f"Risk: {RISK_PCT}% | SL: {SL_ATR}xATR | TP: {TP_ATR}xATR")

    if not connect():
        return

    last_pred = 0
    pred_count = 0

    while True:
        try:
            df = fetch_rates(300)
            if df is None or len(df) < 100:
                time.sleep(10)
                continue

            df = build_features(df)
            signal, confidence = ai_predict(df)
            save_data(df.tail(1))

            if signal == 1:
                log(f">>> AI BUY  | Price={df['close'].iloc[-1]:.2f} | Confidence={confidence:.2%} | RSI={df['RSI'].iloc[-1]:.1f}")
                pred_count += 1
            elif signal == -1:
                log(f">>> AI SELL | Price={df['close'].iloc[-1]:.2f} | Confidence={confidence:.2%} | RSI={df['RSI'].iloc[-1]:.1f}")
                pred_count += 1
            else:
                if pred_count > 0 or last_pred == 0:
                    log(f"No AI signal | Close={df['close'].iloc[-1]:.2f} | Conf={confidence:.2%} | RSI={df['RSI'].iloc[-1]:.1f}")

            last_pred = signal

            # Sync to next minute
            now = datetime.now()
            next_min = (now + timedelta(minutes=1)).replace(second=0, microsecond=0)
            wait = (next_min - now).total_seconds()
            time.sleep(max(wait, 1))

        except KeyboardInterrupt:
            log("Bot stopped")
            break
        except Exception as e:
            log(f"Error: {e}")
            time.sleep(5)

    mt5.shutdown()

if __name__ == "__main__":
    main()
