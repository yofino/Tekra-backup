"""
TEKRA AI — XAUUSD Intelligence Dashboard
with Login + VPS Resource Monitor
"""
import streamlit as st
import pandas as pd
import numpy as np
import json
import os
import subprocess
import psutil
from datetime import datetime, timedelta

# ──── CONFIG ────
st.set_page_config(page_title="Tekra AI | XAUUSD Intelligence", page_icon="🪙", layout="wide")

# ──── AUTH ────
USERS = {
    "yofi":      {"pw": "tekra2026",   "name": "Yofi",   "role": "Admin"},
    "client":    {"pw": "tekraXAU",    "name": "Client", "role": "Viewer"},
}

if "logged_in" not in st.session_state:
    st.session_state.logged_in = False
    st.session_state.user = None

# ──── LOGIN PAGE ────
if not st.session_state.logged_in:
    st.markdown("""
    <style>
        .stApp { background: linear-gradient(135deg, #0a0e17 0%, #111827 50%, #1a2744 100%); }
        .login-title {
            font-family: 'Georgia', serif;
            font-size: 2.5rem; font-weight: 700;
            background: linear-gradient(135deg, #c9a84c, #f4d03f, #c9a84c);
            -webkit-background-clip: text; -webkit-text-fill-color: transparent;
            text-align: center;
        }
    </style>
    """, unsafe_allow_html=True)

    col1, col2, col3 = st.columns([1, 2, 1])
    with col2:
        st.markdown('<br><br>', unsafe_allow_html=True)
        logo_path = r"C:\TradingBot\tekra_logo.png"
        if os.path.exists(logo_path):
            st.image(logo_path, width=250)

        st.markdown('<p class="login-title">XAUUSD Intelligence</p>', unsafe_allow_html=True)
        st.markdown('<p style="text-align:center;color:#8b9dc3;letter-spacing:3px;font-size:0.9rem;margin-bottom:30px">TEKRA ARTIFICIAL INTELLIGENCE TRADING ENGINE</p>', unsafe_allow_html=True)

        with st.form("login_form"):
            username = st.text_input("Username", placeholder="Enter username")
            password = st.text_input("Password", type="password", placeholder="Enter password")
            submitted = st.form_submit_button("🔐 Sign In", use_container_width=True)

            if submitted:
                if username.lower() in USERS and USERS[username.lower()]["pw"] == password:
                    st.session_state.logged_in = True
                    st.session_state.user = USERS[username.lower()]
                    st.rerun()
                else:
                    st.error("Invalid username or password")

    st.stop()

# ══════════════════════════════════════════════════
# MAIN DASHBOARD (after login)
# ══════════════════════════════════════════════════

# ──── PATHS ────
DATA_DIR = r"C:\TradingBot\data"
LOG_FILE = r"C:\TradingBot\bot.log"
MODEL_DIR = r"C:\TradingBot\models"
BACKTEST_DIR = r"C:\TradingBot\backtest"

# ──── PREMIUM STYLE ────
st.markdown("""
<style>
    .stApp { background: linear-gradient(180deg, #0a0e17 0%, #111827 100%); }
    .premium-title {
        font-family: 'Georgia', serif;
        font-size: 2.5rem !important; font-weight: 700 !important;
        background: linear-gradient(135deg, #c9a84c, #f4d03f, #c9a84c);
        -webkit-background-clip: text; -webkit-text-fill-color: transparent;
        text-align: center; letter-spacing: 2px;
    }
    .premium-subtitle {
        font-family: 'Georgia', serif; font-size: 0.85rem;
        color: #8b9dc3; text-align: center; letter-spacing: 4px;
        text-transform: uppercase;
    }
    .gold-divider {
        height: 1px;
        background: linear-gradient(90deg, transparent, #c9a84c, #f4d03f, #c9a84c, transparent);
        margin: 12px 0; border: none;
    }
    .signal-buy-box {
        background: linear-gradient(135deg, #0d3320, #1a4a2e);
        border: 1px solid #2e7d32; border-radius: 12px;
        padding: 18px 25px; margin: 10px 0;
    }
    .signal-sell-box {
        background: linear-gradient(135deg, #3d1a1a, #4a2020);
        border: 1px solid #c62828; border-radius: 12px;
        padding: 18px 25px; margin: 10px 0;
    }
    .vps-card {
        background: linear-gradient(135deg, #1a1f2e, #141926);
        border: 1px solid #2a3040; border-radius: 8px;
        padding: 12px 16px; margin: 4px 0;
    }
    .vps-bar { height: 6px; border-radius: 3px; margin: 4px 0 8px 0; }
    .vps-bar-bg { background: #2a3040; }
    .vps-bar-cpu { background: linear-gradient(90deg, #4caf50, #ff9800, #f44336); }
    .vps-bar-ram { background: linear-gradient(90deg, #2196f3, #9c27b0); }
    .vps-bar-disk { background: linear-gradient(90deg, #00bcd4, #009688); }
</style>
""", unsafe_allow_html=True)

# ──── VPS MONITOR ────
def get_vps_stats():
    cpu_pct = psutil.cpu_percent(interval=0.5)
    ram = psutil.virtual_memory()
    disk = psutil.disk_usage('C:')
    boot = datetime.fromtimestamp(psutil.boot_time())
    uptime = datetime.now() - boot

    # Top processes
    procs = []
    for p in psutil.process_iter(['name','cpu_percent','memory_percent']):
        try:
            if p.info['cpu_percent'] > 0.1:
                procs.append(p.info)
        except: pass
    top = sorted(procs, key=lambda x: x['cpu_percent'], reverse=True)[:3]

    return {
        'cpu': cpu_pct,
        'ram_pct': ram.percent,
        'ram_used': ram.used / (1024**3),
        'ram_total': ram.total / (1024**3),
        'disk_pct': disk.percent,
        'disk_used': disk.used / (1024**3),
        'disk_total': disk.total / (1024**3),
        'uptime': str(uptime).split('.')[0],
        'top_procs': top,
        'cpu_count': psutil.cpu_count(),
        'cpu_freq': psutil.cpu_freq().current if psutil.cpu_freq() else 0
    }

# ──── SIDEBAR ────
with st.sidebar:
    # Logo
    logo_path = r"C:\TradingBot\tekra_logo.png"
    if os.path.exists(logo_path):
        st.image(logo_path, width=180)

    st.markdown('<hr class="gold-divider">', unsafe_allow_html=True)

    # User info
    user = st.session_state.user
    st.markdown(f"👤 **{user['name']}** ({user['role']})")

    # System Status
    st.markdown("### 🖥️ System")
    result = subprocess.run(['tasklist','/FI','IMAGENAME eq python.exe'], capture_output=True, text=True)
    bot_on = 'python.exe' in result.stdout
    if bot_on:
        st.success("BOT RUNNING")
    else:
        st.error("BOT STOPPED")

    st.metric("Server Time", datetime.now().strftime("%H:%M:%S"))
    st.caption(f"{datetime.now().strftime('%d %B %Y')}")

    # ──── VPS RESOURCES ────
    st.markdown('<hr class="gold-divider">', unsafe_allow_html=True)
    st.markdown("### 📊 VPS Resources")

    vps = get_vps_stats()

    # CPU
    cpu_color = "#4caf50" if vps['cpu'] < 50 else ("#ff9800" if vps['cpu'] < 80 else "#f44336")
    st.markdown(f"""
    <div class="vps-card">
        <div style="display:flex;justify-content:space-between">
            <span style="color:#a0b4d0"> CPU</span>
            <span style="color:{cpu_color};font-weight:bold">{vps['cpu']:.1f}%</span>
        </div>
        <div class="vps-bar vps-bar-bg"><div class="vps-bar vps-bar-cpu" style="width:{min(vps['cpu'],100)}%"></div></div>
        <span style="font-size:0.7rem;color:#666">{vps['cpu_count']} cores @ {vps['cpu_freq']:.0f}MHz</span>
    </div>
    """, unsafe_allow_html=True)

    # RAM
    ram_color = "#4caf50" if vps['ram_pct'] < 50 else ("#ff9800" if vps['ram_pct'] < 80 else "#f44336")
    st.markdown(f"""
    <div class="vps-card">
        <div style="display:flex;justify-content:space-between">
            <span style="color:#a0b4d0"> RAM</span>
            <span style="color:{ram_color};font-weight:bold">{vps['ram_pct']:.1f}%</span>
        </div>
        <div class="vps-bar vps-bar-bg"><div class="vps-bar vps-bar-ram" style="width:{vps['ram_pct']}%"></div></div>
        <span style="font-size:0.7rem;color:#666">{vps['ram_used']:.1f} / {vps['ram_total']:.1f} GB</span>
    </div>
    """, unsafe_allow_html=True)

    # Disk
    disk_color = "#4caf50" if vps['disk_pct'] < 60 else ("#ff9800" if vps['disk_pct'] < 85 else "#f44336")
    st.markdown(f"""
    <div class="vps-card">
        <div style="display:flex;justify-content:space-between">
            <span style="color:#a0b4d0"> Disk C:</span>
            <span style="color:{disk_color};font-weight:bold">{vps['disk_pct']:.1f}%</span>
        </div>
        <div class="vps-bar vps-bar-bg"><div class="vps-bar vps-bar-disk" style="width:{vps['disk_pct']}%"></div></div>
        <span style="font-size:0.7rem;color:#666">{vps['disk_used']:.1f} / {vps['disk_total']:.1f} GB</span>
    </div>
    """, unsafe_allow_html=True)

    # Uptime
    st.caption(f"⏱ Uptime: {vps['uptime']}")

    # Top processes
    if vps['top_procs']:
        st.caption("Top processes:")
        for p in vps['top_procs']:
            st.caption(f"  • {p['name'][:20]}: CPU {p['cpu_percent']:.1f}%")

    # Quick Info
    st.markdown('<hr class="gold-divider">', unsafe_allow_html=True)
    st.markdown("### ℹ️ Quick Info")
    st.markdown("""
    <div style='font-size:0.8rem;color:#8b9dc3;line-height:1.6'>
    Model: XGBoost V2<br>
    Timeframe: M5<br>
    Symbol: XAUUSDm<br>
    Broker: Exness<br>
    </div>
    """, unsafe_allow_html=True)

    st.divider()
    if st.button("🚪 Sign Out", use_container_width=True):
        st.session_state.logged_in = False
        st.session_state.user = None
        st.rerun()
    st.caption("© 2026 Tekra AI Trader")

# ──── HEADER ────
st.markdown('<p class="premium-title">XAUUSD Intelligence</p>', unsafe_allow_html=True)
st.markdown('<p class="premium-subtitle">TEKRA ARTIFICIAL INTELLIGENCE TRADING ENGINE</p>', unsafe_allow_html=True)
st.markdown('<hr class="gold-divider">', unsafe_allow_html=True)

# ──── TABS ────
tab1, tab2, tab3 = st.tabs(["📡 Live Market", "📈 Backtest Results", "🧠 AI Engine"])

# ──── TAB 1: MARKET ────
with tab1:
    today = datetime.now().strftime("%Y%m%d")
    csv_path = f"{DATA_DIR}\\xauusd_{today}.csv"

    if os.path.exists(csv_path):
        df = pd.read_csv(csv_path)
        if len(df) > 0:
            last = df.iloc[-1]

            col1,col2,col3,col4,col5 = st.columns(5)
            col1.metric("XAUUSD", f"$ {last.get('close',0):.2f}")
            col2.metric("Spread", f"{last.get('spread',0)/0.01:.0f} pips")
            col3.metric("RSI (14)", f"{last.get('RSI',0):.1f}")
            col4.metric("ATR (14)", f"{last.get('ATR',0):.2f}")
            col5.metric("Volume", f"{last.get('tick_volume',0):,.0f}")

            st.divider()

            ma_cross = last.get('MA_cross', 0)
            rsi_val = last.get('RSI', 50)
            if ma_cross == 1 and 30 < rsi_val < 70:
                st.markdown(f"""
                <div class="signal-buy-box">
                    <p style="font-size:1.2rem;color:#e0e0e0"> <strong>BUY SIGNAL</strong> — XAUUSD ${last['close']:.2f} — RSI {rsi_val:.1f}</p>
                    <p style="color:#81c784;font-size:0.9rem;">MA9 crossover above MA21 · Bullish momentum</p>
                </div>
                """, unsafe_allow_html=True)
            elif ma_cross == -1 and 30 < rsi_val < 70:
                st.markdown(f"""
                <div class="signal-sell-box">
                    <p style="font-size:1.2rem;color:#e0e0e0"> <strong>SELL SIGNAL</strong> — XAUUSD ${last['close']:.2f} — RSI {rsi_val:.1f}</p>
                    <p style="color:#ef9a9a;font-size:0.9rem;">MA9 crossover below MA21 · Bearish momentum</p>
                </div>
                """, unsafe_allow_html=True)
            else:
                st.info("🔇 No signal — monitoring market")

            c1,c2 = st.columns(2)
            with c1:
                st.subheader("Price Action")
                st.line_chart(df[['close']].tail(100), height=250, color='#c9a84c')
            with c2:
                st.subheader("RSI Oscillator")
                st.line_chart(df[['RSI']].tail(100), height=250)

            c3,c4 = st.columns(2)
            with c3:
                st.subheader("MACD")
                if 'MACD' in df.columns:
                    st.line_chart(df[['MACD','MACD_signal']].tail(100), height=200)
            with c4:
                st.subheader("Moving Averages")
                if all(c in df.columns for c in ['close','MA_9','MA_21']):
                    st.line_chart(df[['close','MA_9','MA_21']].tail(100), height=200)
        else:
            st.info("Collecting data... bot is running")
    else:
        st.warning(f"Waiting for today's data... ({today})")

# ──── TAB 2: BACKTEST ────
with tab2:
    st.subheader("📈 Backtest Performance")

    stats_path = f"{BACKTEST_DIR}\\stats_v3.json"
    if os.path.exists(stats_path):
        with open(stats_path) as f:
            stats = json.load(f)

        pnl = stats.get('pnl', 0)
        b1,b2,b3,b4 = st.columns(4)
        b1.metric("Net P&L", f"${pnl:+,.2f}", delta=f"{stats.get('return_pct',0):+.1f}%")
        b2.metric("Win Rate", f"{stats.get('win_rate',0):.1f}%")
        b3.metric("Profit Factor", f"{stats.get('profit_factor',0):.2f}")
        b4.metric("Max Drawdown", f"{stats.get('max_dd',0):.1f}%")

        b5,b6,b7,b8 = st.columns(4)
        b5.metric("Total Trades", stats.get('trades',0))
        b6.metric("Avg Win", f"${stats.get('avg_win',0):+.2f}")
        b7.metric("Avg Loss", f"${stats.get('avg_loss',0):+.2f}")
        b8.metric("TP / SL Hits", f"{stats.get('tp_hits',0)} / {stats.get('sl_hits',0)}")

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
    else:
        st.info("Run backtest_v3.py first to generate results.")

# ──── TAB 3: MODEL ────
with tab3:
    st.subheader("🧠 AI Engine Performance")

    metrics_path = f"{MODEL_DIR}\\metrics_v2.json"
    if os.path.exists(metrics_path):
        with open(metrics_path) as f:
            m = json.load(f)

        acc = m.get('accuracy', 0) * 100
        k1,k2,k3,k4 = st.columns(4)
        k1.metric("Accuracy", f"{acc:.1f}%", delta=f"{(acc-41):.0f}% vs manual")
        k2.metric("Precision", f"{m.get('best_precision',0)*100:.1f}%")
        k3.metric("Recall", f"{m.get('best_recall',0)*100:.1f}%")
        k4.metric("F1 Score", f"{m.get('best_f1',0):.3f}")

        ntr = m.get('n_train','—')
        nva = m.get('n_val','—')
        d1,d2,d3,d4 = st.columns(4)
        d1.metric("Train Samples", f"{ntr:,}" if isinstance(ntr,int) else str(ntr))
        d2.metric("Val Samples", f"{nva:,}" if isinstance(nva,int) else str(nva))
        d3.metric("Features", m.get('n_features','—'))
        d4.metric("Algorithm", "XGBoost")

        model_file = f"{MODEL_DIR}\\xgboost_v2.pkl"
        if os.path.exists(model_file):
            mtime = datetime.fromtimestamp(os.path.getmtime(model_file))
            st.success(f"✅ Model: `xgboost_v2.pkl` · Trained {mtime.strftime('%d %b %Y %H:%M')}")

        if os.path.exists(f"{MODEL_DIR}\\features.json"):
            with open(f"{MODEL_DIR}\\features.json") as f:
                feats = json.load(f)
            with st.expander(f"Feature Engineering ({len(feats)} indicators)"):
                st.code("\n".join(feats), language='text')
    else:
        st.info("Model not yet trained.")

# ──── RECENT SIGNALS ────
st.markdown('<hr class="gold-divider">', unsafe_allow_html=True)
st.subheader("📋 Recent Signal Activity")
if os.path.exists(LOG_FILE):
    with open(LOG_FILE) as f:
        lines = f.readlines()
    sigs = [l.strip() for l in lines if 'SIGNAL' in l or '>>>' in l]
    if sigs:
        for s in reversed(sigs[-8:]):
            if 'BUY' in s: st.success(s)
            elif 'SELL' in s: st.error(s)
            else: st.text(s)
    else:
        st.caption("Awaiting signals...")
