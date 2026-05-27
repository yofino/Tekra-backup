"""
BACKTEST V1 - Test strategy on historical XAUUSD data
"""
import MetaTrader5 as mt5
import pandas as pd
import numpy as np
from datetime import datetime, timedelta
import json

SYMBOL = "XAUUSDm"
OUT_DIR = r"C:\TradingBot\backtest"
LOG = []

def log(msg):
    t = datetime.now().strftime("%H:%M:%S")
    line = f"[{t}] {msg}"
    print(line)
    LOG.append(line)

# ──── CONNECT ────
def connect():
    if not mt5.initialize():
        log(f"MT5 init failed: {mt5.last_error()}")
        return False
    log(f"Connected - {mt5.account_info().login}")
    return True

# ──── FETCH HISTORICAL DATA ────
def fetch_history(n_days=365):
    """Fetch M5 candles for faster download, then resample or use as-is"""
    end = datetime.now()
    start = end - timedelta(days=n_days)
    
    log(f"Fetching {n_days} days of M5 data for {SYMBOL}...")
    rates = mt5.copy_rates_range(SYMBOL, mt5.TIMEFRAME_M5, start, end)
    
    if rates is None:
        log(f"Failed: {mt5.last_error()}")
        return None
    
    df = pd.DataFrame(rates)
    df['time'] = pd.to_datetime(df['time'], unit='s')
    df.set_index('time', inplace=True)
    
    log(f"Got {len(df)} M5 candles ({df.index[0]} to {df.index[-1]})")
    return df

# ──── INDICATORS ────
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

    return df.dropna()

# ──── SIGNAL GENERATION ────
def generate_signals(df):
    """Add BUY/SELL signal column to dataframe"""
    df = df.copy()
    df['signal'] = 0
    
    for i in range(1, len(df)):
        prev = df.iloc[i-1]
        curr = df.iloc[i]
        
        # BUY
        if prev['MA_cross'] <= 0 and curr['MA_cross'] == 1:
            if 30 < curr['RSI'] < 70 and curr['MACD_hist'] > 0:
                df.iloc[i, df.columns.get_loc('signal')] = 1  # BUY
                
        # SELL
        if prev['MA_cross'] >= 0 and curr['MA_cross'] == -1:
            if 30 < curr['RSI'] < 70 and curr['MACD_hist'] < 0:
                df.iloc[i, df.columns.get_loc('signal')] = -1  # SELL
    
    return df

# ──── SIMULATE TRADES ────
def simulate_trades(df, initial_balance=10000, risk_pct=2, sl_atr_mult=1.5, tp_atr_mult=2.0):
    """
    Simulate trades with proper risk management.
    risk_pct: max risk per trade (% of balance)
    sl_atr_mult: stop loss = ATR * multiplier
    tp_atr_mult: take profit = ATR * multiplier
    """
    balance = initial_balance
    trades = []
    in_position = False
    position_type = None
    entry_price = 0
    entry_time = None
    sl_price = 0
    tp_price = 0
    lot_size = 0
    
    for i in range(len(df)):
        row = df.iloc[i]
        
        if not in_position:
            # Check for signal
            if row['signal'] == 1:  # BUY
                in_position = True
                position_type = 'BUY'
                entry_price = row['close']
                entry_time = df.index[i]
                atr = row['ATR']
                
                # Risk-based position sizing
                risk_amount = balance * (risk_pct / 100)
                sl_distance = atr * sl_atr_mult
                tp_distance = atr * tp_atr_mult
                
                sl_price = entry_price - sl_distance
                tp_price = entry_price + tp_distance
                
                # XAUUSD: 1 pip = 0.01, lot 0.01 = ~$0.10/pip
                lot_size = max(0.01, round(risk_amount / (sl_distance / 0.01 * 0.10) * 0.01, 2))
                lot_size = min(lot_size, 1.0)  # Cap at 1 lot
                
            elif row['signal'] == -1:  # SELL
                in_position = True
                position_type = 'SELL'
                entry_price = row['close']
                entry_time = df.index[i]
                atr = row['ATR']
                
                risk_amount = balance * (risk_pct / 100)
                sl_distance = atr * sl_atr_mult
                tp_distance = atr * tp_atr_mult
                
                sl_price = entry_price + sl_distance
                tp_price = entry_price - tp_distance
                
                lot_size = max(0.01, round(risk_amount / (sl_distance / 0.01 * 0.10) * 0.01, 2))
                lot_size = min(lot_size, 1.0)
        
        else:
            # Check exit conditions
            exit_trade = False
            exit_price = 0
            exit_reason = ''
            
            if position_type == 'BUY':
                if row['low'] <= sl_price:
                    exit_trade = True
                    exit_price = sl_price
                    exit_reason = 'SL'
                elif row['high'] >= tp_price:
                    exit_trade = True
                    exit_price = tp_price
                    exit_reason = 'TP'
                elif row['signal'] == -1:  # Reverse signal
                    exit_trade = True
                    exit_price = row['close']
                    exit_reason = 'REVERSE'
                    
            elif position_type == 'SELL':
                if row['high'] >= sl_price:
                    exit_trade = True
                    exit_price = sl_price
                    exit_reason = 'SL'
                elif row['low'] <= tp_price:
                    exit_trade = True
                    exit_price = tp_price
                    exit_reason = 'TP'
                elif row['signal'] == 1:  # Reverse signal
                    exit_trade = True
                    exit_price = row['close']
                    exit_reason = 'REVERSE'
            
            # Time-based exit (hold max 4 hours in M5 = 48 candles)
            if i - df.index.get_loc(entry_time) > 48:
                exit_trade = True
                exit_price = row['close']
                exit_reason = 'TIMEOUT'
            
            if exit_trade:
                # Calculate P&L
                if position_type == 'BUY':
                    pnl_points = (exit_price - entry_price) / 0.01  # in pips
                else:
                    pnl_points = (entry_price - exit_price) / 0.01
                
                pnl_dollars = pnl_points * lot_size * 0.10
                balance += pnl_dollars
                
                trades.append({
                    'entry_time': entry_time,
                    'exit_time': df.index[i],
                    'type': position_type,
                    'entry': round(entry_price, 2),
                    'exit': round(exit_price, 2),
                    'pnl_pips': round(pnl_points, 1),
                    'pnl_usd': round(pnl_dollars, 2),
                    'lots': lot_size,
                    'reason': exit_reason,
                    'balance': round(balance, 2)
                })
                
                in_position = False
                position_type = None
    
    return trades, balance

# ──── ANALYZE RESULTS ────
def analyze(trades, initial_balance, final_balance, df):
    wins = [t for t in trades if t['pnl_usd'] > 0]
    losses = [t for t in trades if t['pnl_usd'] <= 0]
    
    total_pnl = final_balance - initial_balance
    win_rate = len(wins) / len(trades) * 100 if trades else 0
    
    # Average win/loss
    avg_win = np.mean([t['pnl_usd'] for t in wins]) if wins else 0
    avg_loss = np.mean([t['pnl_usd'] for t in losses]) if losses else 0
    
    # Profit factor
    total_wins = sum(t['pnl_usd'] for t in wins)
    total_losses = abs(sum(t['pnl_usd'] for t in losses))
    profit_factor = total_wins / total_losses if total_losses > 0 else float('inf')
    
    # Max drawdown
    balances = [initial_balance] + [t['balance'] for t in trades]
    peak = balances[0]
    max_dd = 0
    for b in balances:
        if b > peak:
            peak = b
        dd = (peak - b) / peak * 100
        max_dd = max(max_dd, dd)
    
    # Sharpe ratio (simplified)
    returns = []
    for t in trades:
        returns.append(t['pnl_usd'] / initial_balance * 100)
    sharpe = np.mean(returns) / np.std(returns) * np.sqrt(252) if returns and np.std(returns) > 0 else 0
    
    report = f"""
========================================
 BACKTEST RESULTS - {SYMBOL}
========================================

DATA: {df.index[0].strftime('%Y-%m-%d')} to {df.index[-1].strftime('%Y-%m-%d')}
CANDLES: {len(df)} (M5)

TRADES: {len(trades)}
  Wins:   {len(wins)} ({win_rate:.1f}%)
  Losses: {len(losses)}

P&L:       ${total_pnl:+.2f}
  Initial: ${initial_balance:,.0f}
  Final:   ${final_balance:,.0f}
  Return:  {total_pnl/initial_balance*100:+.1f}%

AVERAGES:
  Win:    ${avg_win:+.2f}
  Loss:   ${avg_loss:+.2f}
  R:R:    {abs(avg_win/avg_loss) if avg_loss != 0 else 0:.1f}

PROFIT FACTOR: {profit_factor:.2f}
MAX DRAWDOWN:  {max_dd:.1f}%
SHARPE RATIO:  {sharpe:.2f}

SELL SIGNALS: {sum(1 for t in trades if t['type']=='SELL')}
BUY SIGNALS:  {sum(1 for t in trades if t['type']=='BUY')}

STOP LOSS HIT:   {sum(1 for t in trades if t['reason']=='SL')}
TAKE PROFIT HIT: {sum(1 for t in trades if t['reason']=='TP')}
REVERSE EXIT:    {sum(1 for t in trades if t['reason']=='REVERSE')}
TIMEOUT EXIT:    {sum(1 for t in trades if t['reason']=='TIMEOUT')}
========================================
"""
    return report, {
        'trades': len(trades),
        'wins': len(wins),
        'losses': len(losses),
        'win_rate': win_rate,
        'total_pnl': total_pnl,
        'return_pct': total_pnl/initial_balance*100,
        'profit_factor': profit_factor,
        'max_drawdown': max_dd,
        'sharpe': sharpe,
        'avg_win': avg_win,
        'avg_loss': avg_loss,
        'final_balance': final_balance
    }

# ──── MAIN ────
def main(days=365):
    import os
    os.makedirs(OUT_DIR, exist_ok=True)
    
    log(f"===== BACKTEST {SYMBOL} =====")
    log(f"Fetching {days} days history...")
    
    if not connect():
        return
    
    df = fetch_history(days)
    if df is None or len(df) < 100:
        log("Not enough data")
        mt5.shutdown()
        return
    
    log(f"Calculating indicators...")
    df = add_indicators(df)
    
    log(f"Generating signals...")
    df = generate_signals(df)
    
    buy_signals = (df['signal'] == 1).sum()
    sell_signals = (df['signal'] == -1).sum()
    log(f"Signals found: {buy_signals} BUY, {sell_signals} SELL")
    
    log(f"Simulating trades...")
    trades, final_balance = simulate_trades(df)
    
    report, stats = analyze(trades, 10000, final_balance, df)
    print(report)
    
    # Save report
    with open(f"{OUT_DIR}\\backtest_report.txt", "w") as f:
        f.write(report)
        f.write("\n".join(LOG))
    
    # Save trade list
    trades_df = pd.DataFrame(trades)
    if len(trades_df) > 0:
        trades_df.to_csv(f"{OUT_DIR}\\trades.csv", index=False)
    
    # Save stats as JSON
    stats['date'] = datetime.now().strftime('%Y-%m-%d %H:%M')
    stats['data_days'] = days
    with open(f"{OUT_DIR}\\stats.json", "w") as f:
        json.dump(stats, f, indent=2)
    
    log(f"Results saved to {OUT_DIR}")
    mt5.shutdown()
    return trades, stats

if __name__ == "__main__":
    import sys
    days = int(sys.argv[1]) if len(sys.argv) > 1 else 365
    main(days)
