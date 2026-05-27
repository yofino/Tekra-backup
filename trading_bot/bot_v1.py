"""
TRADING BOT V1 — Data Collector + Signal Detector (XAUUSD / Exness)
"""
import MetaTrader5 as mt5
import pandas as pd
import numpy as np
import time
import json
from datetime import datetime, timedelta

# ═══════════════ CONFIG ═══════════════
SYMBOL = "XAUUSDm"
TIMEFRAME = mt5.TIMEFRAME_M1  # 1 menit
DATA_DIR = r"C:\TradingBot\data"
LOG_FILE = r"C:\TradingBot\bot.log"

# ═══════════════ UTILS ═══════════════
def log(msg):
    timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    line = f"[{timestamp}] {msg}"
    print(line)
    with open(LOG_FILE, "a") as f:
        f.write(line + "\n")

# ═══════════════ CONNECT ═══════════════
def connect():
    if not mt5.initialize():
        log(f"❌ MT5 init failed: {mt5.last_error()}")
        return False
    log(f"✅ MT5 connected — {mt5.account_info().login}")
    return True

# ═══════════════ FETCH DATA ═══════════════
def fetch_rates(n_candles=500):
    """Ambil data candle terbaru"""
    rates = mt5.copy_rates_from_pos(SYMBOL, TIMEFRAME, 0, n_candles)
    if rates is None:
        log(f"❌ Gagal ambil data: {mt5.last_error()}")
        return None

    df = pd.DataFrame(rates)
    df['time'] = pd.to_datetime(df['time'], unit='s')
    df.set_index('time', inplace=True)
    return df

# ═══════════════ INDICATORS ═══════════════
def add_indicators(df):
    """Hitung RSI, MACD, Bollinger, MA"""
    # Moving Averages
    df['MA_9'] = df['close'].rolling(9).mean()
    df['MA_21'] = df['close'].rolling(21).mean()
    df['MA_50'] = df['close'].rolling(50).mean()

    # MA Cross signal
    df['MA_cross'] = 0
    df.loc[df['MA_9'] > df['MA_21'], 'MA_cross'] = 1
    df.loc[df['MA_9'] < df['MA_21'], 'MA_cross'] = -1

    # RSI
    delta = df['close'].diff()
    gain = delta.clip(lower=0)
    loss = -delta.clip(upper=0)
    avg_gain = gain.rolling(14).mean()
    avg_loss = loss.rolling(14).mean()
    rs = avg_gain / avg_loss.replace(0, np.nan)
    df['RSI'] = 100 - (100 / (1 + rs))

    # Bollinger Bands
    df['BB_mid'] = df['close'].rolling(20).mean()
    std = df['close'].rolling(20).std()
    df['BB_up'] = df['BB_mid'] + 2 * std
    df['BB_low'] = df['BB_mid'] - 2 * std
    df['BB_width'] = (df['BB_up'] - df['BB_low']) / df['BB_mid'] * 100

    # MACD
    ema12 = df['close'].ewm(span=12).mean()
    ema26 = df['close'].ewm(span=26).mean()
    df['MACD'] = ema12 - ema26
    df['MACD_signal'] = df['MACD'].ewm(span=9).mean()
    df['MACD_hist'] = df['MACD'] - df['MACD_signal']

    # ATR (volatility)
    high_low = df['high'] - df['low']
    high_close = np.abs(df['high'] - df['close'].shift())
    low_close = np.abs(df['low'] - df['close'].shift())
    tr = np.maximum(high_low, np.maximum(high_close, low_close))
    df['ATR'] = tr.rolling(14).mean()

    # Volume anomaly
    df['vol_ratio'] = df['tick_volume'] / df['tick_volume'].rolling(20).mean()

    return df

# ═══════════════ SIGNAL ═══════════════
def generate_signal(df):
    """
    Rules:
    - BUY:  MA9 cross ABOVE MA21 + RSI 30-70 + MACD positif
    - SELL: MA9 cross BELOW MA21 + RSI 30-70 + MACD negatif
    """
    if len(df) < 50:
        return None

    latest = df.iloc[-1]
    prev = df.iloc[-2]

    signal = None
    reasons = []

    # BUY signal
    if prev['MA_cross'] <= 0 and latest['MA_cross'] == 1:
        if 30 < latest['RSI'] < 70:
            if latest['MACD_hist'] > 0:
                signal = "BUY"
                reasons = [
                    "MA9 crossed ABOVE MA21",
                    f"RSI={latest['RSI']:.1f} (bullish zone)",
                    f"MACD hist={latest['MACD_hist']:.3f} > 0"
                ]

    # SELL signal
    if prev['MA_cross'] >= 0 and latest['MA_cross'] == -1:
        if 30 < latest['RSI'] < 70:
            if latest['MACD_hist'] < 0:
                signal = "SELL"
                reasons = [
                    "MA9 crossed BELOW MA21",
                    f"RSI={latest['RSI']:.1f} (bearish zone)",
                    f"MACD hist={latest['MACD_hist']:.3f} < 0"
                ]

    if signal:
        log(f"🚨 SIGNAL: {signal} | {', '.join(reasons)}")
        log(f"   Price: {latest['close']:.2f} | Spread: {(latest['spread']/0.01):.1f} pts")
    else:
        log(f"🔇 No signal | Close={latest['close']:.2f} | RSI={latest['RSI']:.1f} | MA_cross={latest['MA_cross']}")

    return signal

# ═══════════════ SAVE DATA ═══════════════
def save_data(df):
    """Simpen data buat training nanti"""
    import os
    os.makedirs(DATA_DIR, exist_ok=True)

    today = datetime.now().strftime("%Y%m%d")
    csv_path = f"{DATA_DIR}\\xauusd_{today}.csv"

    # Append data ke file harian
    if os.path.exists(csv_path):
        df.to_csv(csv_path, mode='a', header=False)
    else:
        df.to_csv(csv_path)

    # Simpen juga full dataset buat training
    full_path = f"{DATA_DIR}\\xauusd_full.csv"
    if os.path.exists(full_path):
        df.to_csv(full_path, mode='a', header=False)
    else:
        df.to_csv(full_path)

# ═══════════════ MAIN LOOP ═══════════════
def main():
    log("══════ TRADING BOT V1 START ══════")
    log(f"Symbol: {SYMBOL} | Timeframe: M1")

    if not connect():
        return

    while True:
        try:
            df = fetch_rates(n_candles=500)
            if df is None or len(df) < 50:
                log("⏳ Waiting for data...")
                time.sleep(10)
                continue

            df = add_indicators(df)
            signal = generate_signal(df)
            save_data(df.tail(1))

            # Tunggu candle baru (1 menit)
            now = datetime.now()
            next_minute = (now + timedelta(minutes=1)).replace(second=0, microsecond=0)
            wait = (next_minute - now).total_seconds()
            time.sleep(max(wait, 1))

        except KeyboardInterrupt:
            log("🛑 Bot stopped by user")
            break
        except Exception as e:
            log(f"❌ Error: {e}")
            time.sleep(5)

    mt5.shutdown()
    log("══════ BOT STOPPED ══════")

if __name__ == "__main__":
    main()
