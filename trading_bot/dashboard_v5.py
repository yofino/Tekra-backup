"""
TEKRA AI — XAUUSD Intelligence Dashboard V5
+ AI Signal Tracking + Progress History
"""
import streamlit as st
import pandas as pd
import numpy as np
import json
import os
import subprocess
import psutil
from datetime import datetime, timedelta

st.set_page_config(page_title="Tekra AI | XAUUSD Intelligence", page_icon="🪙", layout="wide")

# Auto-refresh every 10s (preserves login session)
st.markdown("""
<script>
    setTimeout(function(){ window.location.reload(); }, 10000);
</script>
""", unsafe_allow_html=True)

# ──── AUTH ────
USERS = {
    "yofi":      {"pw": "tekra2026",   "name": "Yofi",   "role": "Admin"},
    "client":    {"pw": "tekraXAU",    "name": "Client", "role": "Viewer"},
}
if "logged_in" not in st.session_state:
    st.session_state.logged_in = False
    st.session_state.user = None

if not st.session_state.logged_in:
    st.markdown("""
    <style>
        .stApp { background: linear-gradient(135deg, #0a0e17 0%, #111827 50%, #1a2744 100%); }
        .login-title { font-family: 'Georgia', serif; font-size: 2.5rem; font-weight: 700;
            background: linear-gradient(135deg, #c9a84c, #f4d03f, #c9a84c);
            -webkit-background-clip: text; -webkit-text-fill-color: transparent; text-align: center; }
    </style>""", unsafe_allow_html=True)
    col1, col2, col3 = st.columns([1, 2, 1])
    with col2:
        st.markdown('<br><br>', unsafe_allow_html=True)
        logo_path = r"C:\TradingBot\tekra_logo.png"
        if os.path.exists(logo_path): st.image(logo_path, width=250)
        st.markdown('<p class="login-title">XAUUSD Intelligence</p>', unsafe_allow_html=True)
        st.markdown('<p style="text-align:center;color:#8b9dc3;letter-spacing:3px;margin-bottom:30px">TEKRA ARTIFICIAL INTELLIGENCE TRADING ENGINE</p>', unsafe_allow_html=True)
        with st.form("login"):
            u = st.text_input("Username"); p = st.text_input("Password", type="password")
            if st.form_submit_button("Sign In", use_container_width=True):
                if u.lower() in USERS and USERS[u.lower()]["pw"] == p:
                    st.session_state.logged_in = True; st.session_state.user = USERS[u.lower()]; st.rerun()
                else: st.error("Invalid credentials")
    st.stop()

# ══════════════════════════════════════
# MAIN DASHBOARD
# ══════════════════════════════════════

DATA_DIR = r"C:\TradingBot\data"
LOG_FILE = r"C:\TradingBot\bot.log"
AI_LOG = r"C:\TradingBot\bot_ai.log"
MODEL_DIR = r"C:\TradingBot\models"
BACKTEST_DIR = r"C:\TradingBot\backtest"

st.markdown("""
<style>
    .stApp { background: linear-gradient(180deg, #0a0e17 0%, #111827 100%); }
    .premium-title { font-family: 'Georgia', serif; font-size: 2.5rem !important; font-weight: 700 !important;
        background: linear-gradient(135deg, #c9a84c, #f4d03f, #c9a84c);
        -webkit-background-clip: text; -webkit-text-fill-color: transparent; text-align: center; }
    .premium-subtitle { font-family: 'Georgia', serif; font-size: 0.85rem; color: #8b9dc3; text-align: center; letter-spacing: 4px; }
    .gold-divider { height: 1px; background: linear-gradient(90deg, transparent, #c9a84c, #f4d03f, #c9a84c, transparent); margin: 12px 0; border: none; }
    .signal-buy { background: linear-gradient(135deg, #0d3320, #1a4a2e); border: 1px solid #2e7d32; border-radius: 12px; padding: 18px 25px; margin: 10px 0; }
    .signal-sell { background: linear-gradient(135deg, #3d1a1a, #4a2020); border: 1px solid #c62828; border-radius: 12px; padding: 18px 25px; margin: 10px 0; }
    .vps-card { background: linear-gradient(135deg, #1a1f2e, #141926); border: 1px solid #2a3040; border-radius: 8px; padding: 12px 16px; margin: 4px 0; }
    .vps-bar { height: 6px; border-radius: 3px; margin: 4px 0 8px 0; }
    .vps-bg { background: #2a3040; }
    .bar-cpu { background: linear-gradient(90deg, #4caf50, #ff9800, #f44336); }
    .bar-ram { background: linear-gradient(90deg, #2196f3, #9c27b0); }
    .bar-disk { background: linear-gradient(90deg, #00bcd4, #009688); }
    .ai-badge { background: linear-gradient(135deg, #1a237e, #4a148c); color: #e0e0ff; padding: 5px 12px; border-radius: 20px; font-size:0.8rem; font-weight:600; display:inline-block; }
</style>
""", unsafe_allow_html=True)

# ──── VPS Stats ────
def get_vps():
    cpu = psutil.cpu_percent(interval=0.5)
    ram = psutil.virtual_memory()
    disk = psutil.disk_usage('C:')
    boot = datetime.fromtimestamp(psutil.boot_time())
    up = str(datetime.now() - boot).split('.')[0]
    return {
        'cpu': cpu, 'ram_pct': ram.percent, 'ram_used': ram.used/(1024**3),
        'ram_total': ram.total/(1024**3), 'disk_pct': disk.percent,
        'disk_used': disk.used/(1024**3), 'disk_total': disk.total/(1024**3), 'uptime': up
    }

# ──── AI Stats ────
def get_ai_stats():
    """Parse AI log to get progress metrics"""
    if not os.path.exists(AI_LOG):
        return None
    with open(AI_LOG) as f:
        lines = f.readlines()

    starts = [l for l in lines if 'BOT V3 AI START' in l]
    signals = [l for l in lines if '>>> AI' in l]
    buys = [l for l in signals if 'BUY' in l]
    sells = [l for l in signals if 'SELL' in l]
    all_lines = [l for l in lines if 'No AI signal' in l or '>>> AI' in l]

    if not starts:
        return None

    first_start = starts[0].split('[')[1].split(']')[0]
    last_entry = lines[-1].split('[')[1].split(']')[0] if lines else first_start

    # Avg confidence
    confs = []
    for s in signals:
        if 'Confidence=' in s:
            try: confs.append(float(s.split('Confidence=')[1].split('%')[0]))
            except: pass
    avg_conf = np.mean(confs) if confs else 0

    return {
        'started': first_start,
        'total_signals': len(signals),
        'buys': len(buys), 'sells': len(sells),
        'total_checks': len(all_lines),
        'avg_confidence': avg_conf,
        'last_entry': last_entry,
        'model': 'XGBoost V2',
        'features': 25,
        'risk': '0.5% | SL 1.5x | TP 3.0x'
    }

# ──── SIDEBAR ────
with st.sidebar:
    logo_path = r"C:\TradingBot\tekra_logo.png"
    if os.path.exists(logo_path): st.image(logo_path, width=180)
    st.markdown('<hr class="gold-divider">', unsafe_allow_html=True)

    user = st.session_state.user
    st.markdown(f"👤 **{user['name']}** ({user['role']})")

    st.markdown("### 🖥️ System")
    r = subprocess.run(['tasklist','/FI','IMAGENAME eq python.exe'], capture_output=True, text=True)
    bot_on = 'python.exe' in r.stdout
    if bot_on: st.success("BOT RUNNING")
    else: st.error("BOT STOPPED")

    st.metric("Server Time", datetime.now().strftime("%H:%M:%S"))

    # AI Mode indicator
    if os.path.exists(AI_LOG) and bot_on:
        st.markdown('<span class="ai-badge">🧠 AI MODE ACTIVE</span>', unsafe_allow_html=True)
    elif bot_on:
        st.caption("Manual rules mode")

    st.markdown('<hr class="gold-divider">', unsafe_allow_html=True)

    # VPS Resources
    st.markdown("### 📊 VPS Resources")
    v = get_vps()

    def bar(color, pct):
        return f'<div class="vps-bar vps-bg"><div class="vps-bar {color}" style="width:{min(pct,100)}%"></div></div>'

    st.markdown(f'<div class="vps-card"><div style="display:flex;justify-content:space-between"><span>🔲 CPU</span><span style="color:{"#f44336" if v["cpu"]>80 else "#4caf50"};font-weight:bold">{v["cpu"]:.1f}%</span></div>{bar("bar-cpu",v["cpu"])}</div>', unsafe_allow_html=True)
    st.markdown(f'<div class="vps-card"><div style="display:flex;justify-content:space-between"><span>💾 RAM</span><span style="color:{"#f44336" if v["ram_pct"]>80 else "#4caf50"};font-weight:bold">{v["ram_pct"]:.1f}%</span></div>{bar("bar-ram",v["ram_pct"])}<span style="font-size:0.7rem;color:#666">{v["ram_used"]:.1f}/{v["ram_total"]:.1f} GB</span></div>', unsafe_allow_html=True)
    st.markdown(f'<div class="vps-card"><div style="display:flex;justify-content:space-between"><span>💿 Disk</span><span style="color:{"#f44336" if v["disk_pct"]>85 else "#4caf50"};font-weight:bold">{v["disk_pct"]:.1f}%</span></div>{bar("bar-disk",v["disk_pct"])}<span style="font-size:0.7rem;color:#666">{v["disk_used"]:.1f}/{v["disk_total"]:.1f} GB</span></div>', unsafe_allow_html=True)
    st.caption(f"⏱ Uptime: {v['uptime']}")

    st.markdown('<hr class="gold-divider">', unsafe_allow_html=True)
    st.markdown("""
    <div style='font-size:0.8rem;color:#8b9dc3;line-height:1.6'>
    Model: XGBoost V2<br>Timeframe: M5<br>Symbol: XAUUSDm
    </div>""", unsafe_allow_html=True)
    st.divider()
    if st.button("🚪 Sign Out", use_container_width=True):
        st.session_state.logged_in = False; st.rerun()
    st.caption("© 2026 Tekra AI Trader")

# ──── HEADER ────
st.markdown('<p class="premium-title">XAUUSD Intelligence</p>', unsafe_allow_html=True)
st.markdown('<p class="premium-subtitle">TEKRA ARTIFICIAL INTELLIGENCE TRADING ENGINE</p>', unsafe_allow_html=True)
st.markdown('<hr class="gold-divider">', unsafe_allow_html=True)

# ──── TABS ────
tab_names = ["📡 Live Market", "🧠 AI Progress", "📈 Backtest", "📋 Signal Log"]
tabs = st.tabs(tab_names)

# ═══ TAB 1: MARKET ═══
with tabs[0]:
    today = datetime.now().strftime("%Y%m%d")
    csv_path = f"{DATA_DIR}\\xauusd_{today}.csv"
    if os.path.exists(csv_path):
        df = pd.read_csv(csv_path)
        if len(df) > 20:
            # Compute indicators from close/high/low (ignore NaN columns from CSV)
            df['RSI'] = 100 - (100 / (1 + (df['close'].diff().clip(lower=0).rolling(14).mean() / df['close'].diff().clip(upper=0).abs().rolling(14).mean().replace(0, np.nan))))
            hl = df['high'] - df['low']
            hc = np.abs(df['high'] - df['close'].shift())
            lc = np.abs(df['low'] - df['close'].shift())
            df['ATR'] = np.maximum(hl, np.maximum(hc, lc)).rolling(14).mean()
            df['MA_9'] = df['close'].rolling(9).mean()
            df['MA_21'] = df['close'].rolling(21).mean()
            df['MA_cross'] = 0
            df.loc[df['MA_9'] > df['MA_21'], 'MA_cross'] = 1
            df.loc[df['MA_9'] < df['MA_21'], 'MA_cross'] = -1
            # Only drop rows where OUR computed cols are NaN
            df = df.dropna(subset=['RSI','ATR','MA_9','MA_21','MA_cross','close'])

        if len(df) > 0:
            last = df.iloc[-1]
            c1,c2,c3,c4,c5 = st.columns(5)
            c1.metric("XAUUSD", f"$ {last['close']:.2f}")
            c2.metric("Spread", f"{last.get('spread',0)/10:.1f} pips")
            c3.metric("RSI", f"{last.get('RSI',0):.1f}")
            c4.metric("ATR", f"{last.get('ATR',0):.2f}")
            c5.metric("Vol", f"{int(last.get('tick_volume',0)):,}")
            st.divider()

            # AI Signal from live log
            if os.path.exists(AI_LOG):
                with open(AI_LOG) as f:
                    ai_lines = [l.strip() for l in f.readlines() if '>>> AI' in l]
                if ai_lines:
                    ai_last = ai_lines[-1]
                    conf = ai_last.split('Confidence=')[1].split('%')[0] if 'Confidence=' in ai_last else '0'
                    if 'BUY' in ai_last:
                        st.markdown(f'<div class="signal-buy"><p style="font-size:1.2rem">🤖 <strong>AI BUY SIGNAL</strong> — ${last["close"]:.2f} — Confidence {conf}%</p><p style="color:#81c784">XGBoost prediction · AI actively trading</p></div>', unsafe_allow_html=True)
                    elif 'SELL' in ai_last:
                        st.markdown(f'<div class="signal-sell"><p style="font-size:1.2rem">🤖 <strong>AI SELL SIGNAL</strong> — ${last["close"]:.2f} — Confidence {conf}%</p><p style="color:#ef9a9a">XGBoost prediction · AI actively trading</p></div>', unsafe_allow_html=True)
                else:
                    st.info("🤖 AI monitoring — no active signal yet")
            else:
                # Fallback manual
                ma_c = last.get('MA_cross',0); rsi = last.get('RSI',50)
                if ma_c == 1 and 30 < rsi < 70:
                    st.markdown(f'<div class="signal-buy"><p style="font-size:1.2rem">🟢 <strong>BUY SIGNAL</strong> — ${last["close"]:.2f} — RSI {rsi:.1f}</p></div>', unsafe_allow_html=True)
                elif ma_c == -1 and 30 < rsi < 70:
                    st.markdown(f'<div class="signal-sell"><p style="font-size:1.2rem">🔴 <strong>SELL SIGNAL</strong> — ${last["close"]:.2f} — RSI {rsi:.1f}</p></div>', unsafe_allow_html=True)
                else:
                    st.info("🔇 No signal — monitoring market")

            c1,c2 = st.columns(2)
            with c1:
                st.subheader("Price Change")
                price_change = ((df['close'] - df['close'].iloc[0])).tail(120)
                st.line_chart(price_change, height=250)
            with c2:
                st.subheader("RSI (14)")
                st.line_chart(df[['RSI']].tail(120), height=250)
            c3,c4 = st.columns(2)
            with c3:
                st.subheader("MACD")
                ema12 = df['close'].ewm(span=12, adjust=False).mean()
                ema26 = df['close'].ewm(span=26, adjust=False).mean()
                macd_df = pd.DataFrame({'MACD': ema12 - ema26, 'Signal': (ema12 - ema26).ewm(span=9, adjust=False).mean()}).tail(120)
                st.line_chart(macd_df, height=200)
            with c4:
                st.subheader("Price vs MA")
                base = df['close'].iloc[0]
                ma_df = pd.DataFrame({'Close': df['close']-base, 'MA9': df['MA_9']-base, 'MA21': df['MA_21']-base}).tail(120)
                st.line_chart(ma_df, height=200)
        else: st.info("Collecting data...")

# ═══ TAB 2: AI PROGRESS ═══
with tabs[1]:
    ai = get_ai_stats()

    if ai:
        st.subheader("🧠 AI Engine Status")
        st.markdown('<span class="ai-badge" style="font-size:1rem;padding:8px 18px"> ACTIVE — XGBoost V2</span>', unsafe_allow_html=True)

        st.divider()

        # Summary metrics
        a1,a2,a3,a4 = st.columns(4)
        a1.metric("AI Started", ai['started'])
        a2.metric("AI Signals", ai['total_signals'])
        a3.metric("Avg Confidence", f"{ai['avg_confidence']:.1f}%")
        a4.metric("Total Checks", ai['total_checks'])

        a5,a6,a7,a8 = st.columns(4)
        a5.metric("BUY Signals", ai['buys'])
        a6.metric("SELL Signals", ai['sells'])
        with a7:
            if ai['total_signals'] > 0:
                st.metric("BUY/SELL Ratio", f"{ai['buys']/max(ai['sells'],1):.1f}")
        a8.metric("Features", ai['features'])

        st.divider()

        # Progress timeline
        st.subheader(" AI Learning Progress")
        st.markdown(f"""
        <div style="background:linear-gradient(135deg,#1a1f2e,#141926);border:1px solid #2a3040;border-radius:12px;padding:20px;margin:10px 0">
            <h4 style="color:#c9a84c;margin:0">Phase 1: Data Collection & Training</h4>
            <p style="color:#8b9dc3;margin:5px 0">Started: 27 May 2026 | Data: 17,316 candles (90 days)</p>
            <div style="background:#2a3040;border-radius:10px;height:8px;margin:10px 0">
                <div style="background:linear-gradient(90deg,#4caf50,#2196f3);width:100%;height:8px;border-radius:10px"></div>
            </div>
            <span style="color:#4caf50;font-size:0.8rem">✅ Complete</span>
        </div>

        <div style="background:linear-gradient(135deg,#1a1f2e,#141926);border:1px solid #2a3040;border-radius:12px;padding:20px;margin:10px 0">
            <h4 style="color:#c9a84c;margin:0">Phase 2: AI Model Training (XGBoost V2)</h4>
            <p style="color:#8b9dc3;margin:5px 0">Accuracy: 59.7% | Features: 25 | Backtest: +13.4% profit</p>
            <div style="background:#2a3040;border-radius:10px;height:8px;margin:10px 0">
                <div style="background:linear-gradient(90deg,#4caf50,#2196f3);width:100%;height:8px;border-radius:10px"></div>
            </div>
            <span style="color:#4caf50;font-size:0.8rem">✅ Complete</span>
        </div>

        <div style="background:linear-gradient(135deg,#1a2744,#1a1f2e);border:2px solid #4caf50;border-radius:12px;padding:20px;margin:10px 0">
            <h4 style="color:#c9a84c;margin:0">Phase 3: AI Live Trading</h4>
            <p style="color:#8b9dc3;margin:5px 0">AI actively predicting BUY/SELL every minute | Started {ai['started']}</p>
            <div style="background:#2a3040;border-radius:10px;height:8px;margin:10px 0">
                <div style="background:linear-gradient(90deg,#ff9800,#ff9800);width:15%;height:8px;border-radius:10px"></div>
            </div>
            <span style="color:#ff9800;font-size:0.8rem">🔄 IN PROGRESS — {ai['total_signals']} signals generated | {ai['total_checks']} checks performed</span>
        </div>

        <div style="background:linear-gradient(135deg,#1a1f2e,#141926);border:1px solid #2a3040;border-radius:12px;padding:20px;margin:10px 0">
            <h4 style="color:#666;margin:0">Phase 4: Weekly Retraining & Optimization</h4>
            <p style="color:#666;margin:5px 0">Auto-retrain model with new data | Optimize SL/TP parameters</p>
            <span style="color:#666;font-size:0.8rem">⏳ Pending — scheduled weekly</span>
        </div>

        <div style="background:linear-gradient(135deg,#1a1f2e,#141926);border:1px solid #2a3040;border-radius:12px;padding:20px;margin:10px 0">
            <h4 style="color:#666;margin:0">Phase 5: Forward Testing & Evaluation</h4>
            <p style="color:#666;margin:5px 0">2-4 weeks demo performance review before real account</p>
            <span style="color:#666;font-size:0.8rem">⏳ Pending — after 2 weeks of live AI data</span>
        </div>
        """, unsafe_allow_html=True)

        # AI decision distribution
        st.subheader("AI Signal Distribution")
        if ai['total_signals'] > 0:
            chart_data = pd.DataFrame({'Type': ['BUY', 'SELL'], 'Count': [ai['buys'], ai['sells']]})
            st.bar_chart(chart_data.set_index('Type'), height=200)

    else:
        st.info("🧠 AI mode not yet active. AI bot has not started generating signals.")
        st.markdown("""
        **How to activate AI:**
        1. Ensure `bot_v3_ai.py` is running (replaces manual rules)
        2. Check `bot_ai.log` for AI signals
        3. This tab will show AI progress automatically
        """)

# ═══ TAB 3: BACKTEST ═══
with tabs[2]:
    st.subheader("📈 Backtest Performance")
    sp = f"{BACKTEST_DIR}\\stats_v3.json"
    if os.path.exists(sp):
        with open(sp) as f: stats = json.load(f)
        b1,b2,b3,b4 = st.columns(4)
        b1.metric("Net P&L", f"${stats.get('pnl',0):+,.2f}", delta=f"{stats.get('return_pct',0):+.1f}%")
        b2.metric("Win Rate", f"{stats.get('win_rate',0):.1f}%")
        b3.metric("Profit Factor", f"{stats.get('profit_factor',0):.2f}")
        b4.metric("Max Drawdown", f"{stats.get('max_dd',0):.1f}%")
        b5,b6,b7,b8 = st.columns(4)
        b5.metric("Trades", stats.get('trades',0))
        b6.metric("Avg Win", f"${stats.get('avg_win',0):+.2f}")
        b7.metric("Avg Loss", f"${stats.get('avg_loss',0):+.2f}")
        b8.metric("TP/SL", f"{stats.get('tp_hits',0)}/{stats.get('sl_hits',0)}")
        st.divider()
        st.subheader("Strategy Comparison")
        st.table({
            "Strategy": ["Manual Rules", "AI V2 (No SL/TP)", "AI V3 + SL/TP ✅"],
            "Trades": ["220", "81", str(stats.get('trades','—'))],
            "Win Rate": ["41.4%", "59%", f"{stats.get('win_rate',0):.1f}%"],
            "P&L": ["-$7.68", "-$28.89", f"${stats.get('pnl',0):+,.2f}"],
            "Return": ["-0.1%", "-0.3%", f"{stats.get('return_pct',0):+.1f}%"],
            "PF": ["0.97", "—", f"{stats.get('profit_factor',0):.2f}"],
        })
    else: st.info("Run backtest_v3.py first.")

# ═══ TAB 4: SIGNAL LOG ═══
with tabs[3]:
    st.subheader("📋 Recent Signal Activity")

    colA, colB = st.columns(2)
    with colA:
        st.markdown("#### 🤖 AI Signals")
        if os.path.exists(AI_LOG):
            with open(AI_LOG) as f: lines = [l.strip() for l in f.readlines() if '>>> AI' in l or 'No AI signal' in l]
            for s in reversed(lines[-15:]):
                if 'BUY' in s: st.success(s)
                elif 'SELL' in s: st.error(s)
                else: st.caption(s)
        else: st.caption("No AI signals yet")

    with colB:
        st.markdown("#### 📐 Manual Rules Signal")
        if os.path.exists(LOG_FILE):
            with open(LOG_FILE) as f: lines = [l.strip() for l in f.readlines() if '>>>' in l]
            for s in reversed(lines[-15:]):
                if 'BUY' in s: st.success(s)
                elif 'SELL' in s: st.error(s)
        else: st.caption("No manual signals")
