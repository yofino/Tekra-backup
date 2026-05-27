import MetaTrader5 as mt5
import pandas as pd
import numpy as np
import time
import os
from datetime import datetime, timedelta

SYMBOL = "XAUUSDm"
TIMEFRAME = mt5.TIMEFRAME_M1
DATA_DIR = r"C:\TradingBot\data"
LOG_FILE = r"C:\TradingBot\bot.log"

def log(msg):
    t = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    line = f"[{t}] {msg}"
    print(line)
    with open(LOG_FILE, "a") as f:
        f.write(line + "\n")

def connect():
    if not mt5.initialize():
        log(f"MT5 init failed: {mt5.last_error()}")
        return False
    log(f"MT5 connected - {mt5.account_info().login}")
    return True

def fetch_rates(n=500):
    rates = mt5.copy_rates_from_pos(SYMBOL, TIMEFRAME, 0, n)
    if rates is None:
        log(f"Failed to fetch: {mt5.last_error()}")
        return None
    df = pd.DataFrame(rates)
    df['time'] = pd.to_datetime(df['time'], unit='s')
    df.set_index('time', inplace=True)
    return df

def add_indicators(df):
    df['MA_9'] = df['close'].rolling(9).mean()
    df['MA_21'] = df['close'].rolling(21).mean()
    df['MA_50'] = df['close'].rolling(50).mean()

    df['MA_cross'] = 0
    df.loc[df['MA_9'] > df['MA_21'], 'MA_cross'] = 1
    df.loc[df['MA_9'] < df['MA_21'], 'MA_cross'] = -1

    delta = df['close'].diff()
    gain = delta.clip(lower=0)
    loss = -delta.clip(upper=0)
    avg_gain = gain.rolling(14).mean()
    avg_loss = loss.rolling(14).mean()
    rs = avg_gain / avg_loss.replace(0, np.nan)
    df['RSI'] = 100 - (100 / (1 + rs))

    df['BB_mid'] = df['close'].rolling(20).mean()
    std = df['close'].rolling(20).std()
    df['BB_up'] = df['BB_mid'] + 2 * std
    df['BB_low'] = df['BB_mid'] - 2 * std

    ema12 = df['close'].ewm(span=12).mean()
    ema26 = df['close'].ewm(span=26).mean()
    df['MACD'] = ema12 - ema26
    df['MACD_signal'] = df['MACD'].ewm(span=9).mean()
    df['MACD_hist'] = df['MACD'] - df['MACD_signal']

    hl = df['high'] - df['low']
    hc = np.abs(df['high'] - df['close'].shift())
    lc = np.abs(df['low'] - df['close'].shift())
    tr = np.maximum(hl, np.maximum(hc, lc))
    df['ATR'] = tr.rolling(14).mean()

    return df

def generate_signal(df):
    if len(df) < 50:
        return None
    latest = df.iloc[-1]
    prev = df.iloc[-2]

    if prev['MA_cross'] <= 0 and latest['MA_cross'] == 1:
        if 30 < latest['RSI'] < 70 and latest['MACD_hist'] > 0:
            log(f">>> BUY | Price={latest['close']:.2f} | RSI={latest['RSI']:.1f}")
            return "BUY"

    if prev['MA_cross'] >= 0 and latest['MA_cross'] == -1:
        if 30 < latest['RSI'] < 70 and latest['MACD_hist'] < 0:
            log(f">>> SELL | Price={latest['close']:.2f} | RSI={latest['RSI']:.1f}")
            return "SELL"

    log(f"No signal | Close={latest['close']:.2f} | RSI={latest['RSI']:.1f}")
    return None

def save_data(df):
    os.makedirs(DATA_DIR, exist_ok=True)
    today = datetime.now().strftime("%Y%m%d")
    path = f"{DATA_DIR}\\xauusd_{today}.csv"
    if os.path.exists(path):
        df.to_csv(path, mode='a', header=False)
    else:
        df.to_csv(path)

def main():
    log("===== BOT V1 START =====")
    if not connect():
        return
    while True:
        try:
            df = fetch_rates(500)
            if df is None or len(df) < 50:
                time.sleep(10)
                continue
            df = add_indicators(df)
            generate_signal(df)
            save_data(df.tail(1))
            now = datetime.now()
            next_min = (now + timedelta(minutes=1)).replace(second=0, microsecond=0)
            time.sleep(max((next_min - now).total_seconds(), 1))
        except KeyboardInterrupt:
            log("Bot stopped by user")
            break
        except Exception as e:
            log(f"Error: {e}")
            time.sleep(5)
    mt5.shutdown()

if __name__ == "__main__":
    main()
