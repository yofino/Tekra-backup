"""
BACKTEST V3 - With SL/TP Risk Management
Loads trained model, applies proper stop loss & take profit
"""
import MetaTrader5 as mt5
import pandas as pd
import numpy as np
import pickle, json, os
from datetime import datetime, timedelta

SYMBOL = "XAUUSDm"
MODEL_PATH = r"C:\TradingBot\models\xgboost_v2.pkl"
SL_ATR = 1.5      # Stop Loss = ATR * 1.5
TP_ATR = 3.0      # Take Profit = ATR * 3.0 (R:R = 2:1)
RISK_PCT = 1.0    # Risk 1% per trade
INITIAL = 10000

def log(msg):
    print(f"[{datetime.now().strftime('%H:%M:%S')}] {msg}")

# ──── FETCH DATA ────
def fetch_data():
    mt5.initialize()
    end = datetime.now()
    start = end - timedelta(days=90)
    rates = mt5.copy_rates_range(SYMBOL, mt5.TIMEFRAME_M5, start, end)
    mt5.shutdown()
    if rates is None: return None
    df = pd.DataFrame(rates)
    df['time'] = pd.to_datetime(df['time'], unit='s')
    df.set_index('time', inplace=True)
    return df

# ──── FEATURES (same as V2) ────
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

# ──── BACKTEST WITH SL/TP ────
def backtest_sltp(df, model_data):
    model = model_data['model']
    features = model_data['features']
    threshold = model_data['threshold']

    data = df.dropna(subset=features).copy()
    split = int(len(data) * 0.75)
    data_val = data.iloc[split:].copy()

    X = data_val[features]
    data_val['pred_proba'] = model.predict_proba(X)[:, 1]
    data_val['signal'] = 0
    data_val.loc[data_val['pred_proba'] >= threshold, 'signal'] = 1
    data_val.loc[data_val['pred_proba'] <= (1 - threshold), 'signal'] = -1

    balance = INITIAL
    trades = []
    position = None
    entry_price = entry_time = sl = tp = lot = entry_atr = 0

    for idx, row in data_val.iterrows():
        sig = row['signal']

        if position == 'buy':
            # Check SL/TP
            exit_price = None
            reason = ''
            if row['low'] <= sl:
                exit_price = sl
                reason = 'SL'
            elif row['high'] >= tp:
                exit_price = tp
                reason = 'TP'
            elif sig == -1:
                exit_price = row['close']
                reason = 'SIGNAL_REVERSE'

            if exit_price:
                pip_val = 0.10 * lot / 0.01
                pnl = (exit_price - entry_price) / 0.01 * pip_val
                balance += pnl
                trades.append({
                    'entry': entry_time, 'exit': idx, 'type': 'BUY',
                    'entry_p': round(entry_price, 2), 'exit_p': round(exit_price, 2),
                    'pnl': round(pnl, 2), 'bal': round(balance, 2),
                    'reason': reason, 'atr': round(entry_atr, 2)
                })
                position = None

        elif position == 'sell':
            exit_price = None
            reason = ''
            if row['high'] >= sl:
                exit_price = sl
                reason = 'SL'
            elif row['low'] <= tp:
                exit_price = tp
                reason = 'TP'
            elif sig == 1:
                exit_price = row['close']
                reason = 'SIGNAL_REVERSE'

            if exit_price:
                pip_val = 0.10 * lot / 0.01
                pnl = (entry_price - exit_price) / 0.01 * pip_val
                balance += pnl
                trades.append({
                    'entry': entry_time, 'exit': idx, 'type': 'SELL',
                    'entry_p': round(entry_price, 2), 'exit_p': round(exit_price, 2),
                    'pnl': round(pnl, 2), 'bal': round(balance, 2),
                    'reason': reason, 'atr': round(entry_atr, 2)
                })
                position = None

        # Open new position
        if position is None:
            if sig == 1:
                position = 'buy'
                entry_price = row['close']
                entry_time = idx
                entry_atr = row['ATR']
                sl = entry_price - entry_atr * SL_ATR
                tp = entry_price + entry_atr * TP_ATR
                risk = balance * RISK_PCT / 100
                sl_price_distance = entry_price - sl
                lot = max(0.01, round(risk / (sl_price_distance / 0.01 * 0.10) * 0.01, 2))

            elif sig == -1:
                position = 'sell'
                entry_price = row['close']
                entry_time = idx
                entry_atr = row['ATR']
                sl = entry_price + entry_atr * SL_ATR
                tp = entry_price - entry_atr * TP_ATR
                risk = balance * RISK_PCT / 100
                sl_price_distance = sl - entry_price
                lot = max(0.01, round(risk / (sl_price_distance / 0.01 * 0.10) * 0.01, 2))

    return trades, balance

# ──── ANALYZE ────
def analyze(trades, balance):
    wins = [t for t in trades if t['pnl'] > 0]
    losses = [t for t in trades if t['pnl'] <= 0]
    total_pnl = balance - INITIAL
    win_rate = len(wins) / max(len(trades), 1) * 100

    avg_win = np.mean([t['pnl'] for t in wins]) if wins else 0
    avg_loss = np.mean([t['pnl'] for t in losses]) if losses else 0

    gross_win = sum(t['pnl'] for t in wins)
    gross_loss = abs(sum(t['pnl'] for t in losses))
    profit_factor = gross_win / gross_loss if gross_loss > 0 else float('inf')

    # Equity curve for drawdown
    balances = [INITIAL] + [t['bal'] for t in trades]
    peak = balances[0]
    max_dd = 0
    for b in balances:
        peak = max(peak, b)
        dd = (peak - b) / peak * 100
        max_dd = max(max_dd, dd)

    # By reason
    tp_hits = sum(1 for t in trades if t['reason'] == 'TP')
    sl_hits = sum(1 for t in trades if t['reason'] == 'SL')

    report = f"""
========================================
 BACKTEST V3 - WITH SL/TP
 Risk: {RISK_PCT}% per trade | SL: {SL_ATR}x ATR | TP: {TP_ATR}x ATR
 R:R = 1:{TP_ATR/SL_ATR:.1f}
========================================

TRADES:  {len(trades)}
WINS:    {len(wins)} ({win_rate:.1f}%)
LOSSES:  {len(losses)}

P&L:       ${total_pnl:+.2f}
FINAL:     ${balance:,.2f}
RETURN:    {total_pnl/INITIAL*100:+.1f}%

AVG WIN:   ${avg_win:+.2f}
AVG LOSS:  ${avg_loss:+.2f}
R:R WIN:   {abs(avg_win/avg_loss) if avg_loss != 0 else 0:.1f}

PROFIT FACTOR: {profit_factor:.2f}
MAX DRAWDOWN:  {max_dd:.1f}%

TP HITS:  {tp_hits}
SL HITS:  {sl_hits}
SIGNAL REVERSE: {len(trades) - tp_hits - sl_hits}

BUY:  {sum(1 for t in trades if t['type']=='BUY')}
SELL: {sum(1 for t in trades if t['type']=='SELL')}
========================================
"""
    return report, {'trades': len(trades), 'wins': len(wins), 'losses': len(losses),
                    'win_rate': win_rate, 'pnl': total_pnl, 'return_pct': total_pnl/INITIAL*100,
                    'profit_factor': profit_factor, 'max_dd': max_dd,
                    'avg_win': avg_win, 'avg_loss': avg_loss,
                    'tp_hits': tp_hits, 'sl_hits': sl_hits}

# ──── MAIN ────
def main():
    log("===== BACKTEST V3 - WITH SL/TP =====")

    # Load model
    with open(MODEL_PATH, 'rb') as f:
        model_data = pickle.load(f)
    log(f"Model loaded: {MODEL_PATH}")
    log(f"Features: {len(model_data['features'])} | Threshold: {model_data['threshold']}")

    df = fetch_data()
    if df is None: return
    df = build_features(df)

    trades, balance = backtest_sltp(df, model_data)
    report, stats = analyze(trades, balance)
    print(report)

    # Save
    with open(r"C:\TradingBot\backtest\report_v3.txt", "w") as f:
        f.write(report)
    with open(r"C:\TradingBot\backtest\stats_v3.json", "w") as f:
        json.dump(stats, f, indent=2)
    log("Saved to C:\\TradingBot\\backtest\\")

    log(f"\nCOMPARISON:")
    log(f"  Manual rules:   220 trades, 41% win, -$7.68")
    log(f"  AI no SL/TP:    81 trades,  59% win, -$28.89")
    log(f"  AI WITH SL/TP:  {stats['trades']} trades, {stats['win_rate']:.0f}% win, ${stats['pnl']:+.2f}")

if __name__ == "__main__":
    main()
