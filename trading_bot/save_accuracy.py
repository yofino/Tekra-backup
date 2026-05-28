"""
Save live accuracy to JSON for dashboard
Runs every 5 minutes via scheduled task
"""
import re, json, pandas as pd, os
from datetime import datetime, timedelta

LOG = r"C:\TradingBot\bot_ai.log"
DATA_DIR = r"C:\TradingBot\data"
OUT = r"C:\TradingBot\live_accuracy.json"

today = datetime.now().strftime("%Y%m%d")
yesterday = (datetime.now() - timedelta(days=1)).strftime("%Y%m%d")

# Load price data
prices = None
for d in [yesterday, today]:
    cp = os.path.join(DATA_DIR, f"xauusd_{d}.csv")
    if os.path.exists(cp):
        df = pd.read_csv(cp)
        df['time'] = pd.to_datetime(df['time'])
        df.set_index('time', inplace=True)
        prices = pd.concat([prices, df]) if prices is not None else df

if prices is None:
    result = {"error": "No price data", "time": str(datetime.now())}
    with open(OUT, 'w') as f: json.dump(result, f)
    exit()

last_price_time = prices.index[-1]

# Parse signals
with open(LOG) as f:
    lines = f.readlines()

signals = [l for l in lines if '>>> AI' in l]
buys = [l for l in signals if 'BUY' in l]
sells = [l for l in signals if 'SELL' in l]

# Accuracy check
results = {'correct': 0, 'wrong': 0}
high_conf = {'correct': 0, 'wrong': 0}
checked = 0

confs = []
for s in signals[-500:]:
    m = re.search(r"\[(.*?)\].*>>> AI (BUY|SELL).*Price=([\d.]+).*Confidence=([\d.]+)%", s)
    if not m: continue
    
    sig_time = pd.to_datetime(m.group(1))
    sig_type = m.group(2)
    sig_price = float(m.group(3))
    sig_conf = float(m.group(4))
    confs.append(sig_conf)
    
    target = sig_time + timedelta(minutes=30)
    if target > last_price_time: continue
    
    future = prices[prices.index >= target]
    if len(future) == 0: continue
    
    future_price = future.iloc[0]['close']
    move = future_price - sig_price
    correct = (sig_type == 'BUY' and move > 0) or (sig_type == 'SELL' and move < 0)
    
    results['correct' if correct else 'wrong'] += 1
    if sig_conf >= 75:
        high_conf['correct' if correct else 'wrong'] += 1
    checked += 1

total = results['correct'] + results['wrong']
live_acc = results['correct'] / total * 100 if total > 0 else None

total_hc = high_conf['correct'] + high_conf['wrong']
hc_acc = high_conf['correct'] / total_hc * 100 if total_hc > 0 else None

avg_conf = sum(confs) / len(confs) if confs else 0
max_conf = max(confs) if confs else 0

result = {
    "time": datetime.now().strftime("%Y-%m-%d %H:%M"),
    "live_accuracy": round(live_acc, 1) if live_acc else None,
    "high_conf_accuracy": round(hc_acc, 1) if hc_acc else None,
    "signals_checked": checked,
    "total_signals": len(signals),
    "buys": len(buys),
    "sells": len(sells),
    "avg_confidence": round(avg_conf, 1),
    "max_confidence": round(max_conf, 1),
    "data_rows": len(prices)
}

with open(OUT, 'w') as f:
    json.dump(result, f)

print(f"Saved: accuracy={live_acc}%, high_conf={hc_acc}%, checked={checked}")
