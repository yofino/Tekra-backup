"""
TEKRA AI — XAUUSD Intelligence Dashboard
"""
import streamlit as st
import pandas as pd
import numpy as np
import json
import os
from datetime import datetime, timedelta
import subprocess

st.set_page_config(page_title="Tekra AI | XAUUSD Intelligence", page_icon="🪙", layout="wide")

# ──── PATHS ────
DATA_DIR = r"C:\TradingBot\data"
LOG_FILE = r"C:\TradingBot\bot.log"
MODEL_DIR = r"C:\TradingBot\models"
BACKTEST_DIR = r"C:\TradingBot\backtest"

# ──── PREMIUM STYLE ────
st.markdown("""
<style>
    @import url('https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;600;700&display=swap');
    .stApp { background: linear-gradient(180deg, #0a0e17 0%, #111827 100%); }
    .sidebar .sidebar-content { background: #0d1117; }

    .premium-title {
        font-family: 'Playfair Display', 'Georgia', serif;
        font-size: 2.8rem !important;
        font-weight: 700 !important;
        background: linear-gradient(135deg, #c9a84c 0%, #f4d03f 30%, #e6b800 50%, #c9a84c 100%);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
        text-align: center;
        letter-spacing: 3px;
        margin: 0;
        padding: 0;
    }
    .premium-subtitle {
        font-family: 'Playfair Display', serif;
        font-size: 1rem;
        color: #8b9dc3;
        text-align: center;
        letter-spacing: 5px;
        text-transform: uppercase;
        margin-top: -5px;
    }
    .gold-divider {
        height: 2px;
        background: linear-gradient(90deg, transparent, #c9a84c, #f4d03f, #c9a84c, transparent);
        margin: 15px 0;
        border: none;
    }
    .metric-card {
        background: linear-gradient(180deg, #1a1f2e, #141926);
        border: 1px solid #2a3040;
        border-radius: 10px;
        padding: 15px;
    }
    .signal-buy-box {
        background: linear-gradient(135deg, #0d3320, #1a4a2e);
        border: 1px solid #2e7d32;
        border-radius: 12px;
        padding: 18px 25px;
        margin: 10px 0;
    }
    .signal-sell-box {
        background: linear-gradient(135deg, #3d1a1a, #4a2020);
        border: 1px solid #c62828;
        border-radius: 12px;
        padding: 18px 25px;
        margin: 10px 0;
    }
    .signal-text {
        font-family: 'Georgia', serif;
        font-size: 1.3rem;
        color: #e0e0e0;
    }
</style>
""", unsafe_allow_html=True)

# ──── SIDEBAR ────
with st.sidebar:
    # Logo
    logo_path = r"C:\TradingBot\tekra_logo.png"
    if os.path.exists(logo_path):
        st.image(logo_path, width=180)

    st.markdown('<hr class="gold-divider">', unsafe_allow_html=True)

    # System Status
    st.markdown("###  System")
    result = subprocess.run(['tasklist','/FI','IMAGENAME eq python.exe'], capture_output=True, text=True)
    bot_on = 'python.exe' in result.stdout
    if bot_on:
        st.success("**BOT RUNNING**")
    else:
        st.error("**BOT STOPPED**")

    st.metric("Server Time", datetime.now().strftime("%H:%M:%S"))
    st.caption(f"{datetime.now().strftime('%d %B %Y')}")

    st.markdown('<hr class="gold-divider">', unsafe_allow_html=True)

    # Quick Info
    st.markdown("###  Quick Info")
    st.markdown("""
    <div style='font-size:0.85rem;color:#8b9dc3;line-height:1.6'>
    Model: XGBoost V2<br>
    Timeframe: M5<br>
    Symbol: XAUUSDm<br>
    Broker: Exness<br>
    </div>
    """, unsafe_allow_html=True)

    st.divider()
    st.caption("© 2026 Tekra AI Trader")

# ──── HEADER ────
st.markdown('<p class="premium-title">XAUUSD Intelligence</p>', unsafe_allow_html=True)
st.markdown('<p class="premium-subtitle">TEKRA ARTIFICIAL INTELLIGENCE TRADING ENGINE</p>', unsafe_allow_html=True)
st.markdown('<hr class="gold-divider">', unsafe_allow_html=True)

# ──── TABS ────
tab1, tab2, tab3 = st.tabs([" Live Market", " Backtest Results", " Model Performance"])

# ──── TAB 1: MARKET ────
with tab1:
    today = datetime.now().strftime("%Y%m%d")
    csv_path = f"{DATA_DIR}\\xauusd_{today}.csv"

    if os.path.exists(csv_path):
        df = pd.read_csv(csv_path)
        if len(df) > 0:
            last = df.iloc[-1]

            # Price row
            col1,col2,col3,col4,col5 = st.columns(5)
            with col1:
                st.metric("XAUUSD", f"$ {last.get('close',0):.2f}")
            with col2:
                sp = last.get('spread', 0) / 0.01
                st.metric("Spread", f"{sp:.0f} pips")
            with col3:
                st.metric("RSI (14)", f"{last.get('RSI',0):.1f}")
            with col4:
                st.metric("ATR (14)", f"{last.get('ATR',0):.2f}")
            with col5:
                st.metric("Volume", f"{last.get('tick_volume',0):,.0f}")

            st.divider()

            # Signal
            ma_cross = last.get('MA_cross', 0)
            rsi_val = last.get('RSI', 50)
            if ma_cross == 1 and 30 < rsi_val < 70:
                st.markdown(f"""
                <div class="signal-buy-box">
                    <p class="signal-text"> <strong>BUY SIGNAL</strong> — XAUUSD ${last['close']:.2f} — RSI {rsi_val:.1f}</p>
                    <p style="color:#81c784;font-size:0.9rem;">MA9 crossover above MA21 · Bullish momentum detected</p>
                </div>
                """, unsafe_allow_html=True)
            elif ma_cross == -1 and 30 < rsi_val < 70:
                st.markdown(f"""
                <div class="signal-sell-box">
                    <p class="signal-text"> <strong>SELL SIGNAL</strong> — XAUUSD ${last['close']:.2f} — RSI {rsi_val:.1f}</p>
                    <p style="color:#ef9a9a;font-size:0.9rem;">MA9 crossover below MA21 · Bearish momentum detected</p>
                </div>
                """, unsafe_allow_html=True)
            else:
                st.info("  No signal — monitoring market volatility")

            # Charts
            c1,c2 = st.columns(2)
            with c1:
                st.subheader("Price Action")
                st.line_chart(df[['close']].tail(100), height=250, color='#c9a84c')
            with c2:
                st.subheader("RSI Oscillator")
                rsi_chart = df[['RSI']].tail(100).copy()
                st.line_chart(rsi_chart, height=250)

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
            st.info("⏳ Collecting data... bot is running")
    else:
        st.warning(f"Waiting for today's data... ({today})")

# ──── TAB 2: BACKTEST ────
with tab2:
    st.subheader("Backtest Performance")

    stats_path = f"{BACKTEST_DIR}\\stats_v3.json"
    if os.path.exists(stats_path):
        with open(stats_path) as f:
            stats = json.load(f)

        pnl = stats.get('pnl', 0)
        wr = stats.get('win_rate', 0)

        b1,b2,b3,b4 = st.columns(4)
        b1.metric("Net P&L", f"${pnl:+,.2f}", delta=f"{stats.get('return_pct',0):+.1f}%")
        b2.metric("Win Rate", f"{wr:.1f}%")
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
            "Strategy": ["Manual Rules", "AI V2 (No SL/TP)", "AI V3 + SL/TP  "],
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
    st.subheader(" AI Engine Performance")

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
            st.success(f" Model: `xgboost_v2.pkl` · Trained {mtime.strftime('%d %b %Y %H:%M')}")

        if os.path.exists(f"{MODEL_DIR}\\features.json"):
            with open(f"{MODEL_DIR}\\features.json") as f:
                feats = json.load(f)
            with st.expander(f"Feature Engineering ({len(feats)} indicators)"):
                st.code("\n".join(feats), language='text')
    else:
        st.info("Model not yet trained. Run train_v2.py first.")

# ──── RECENT SIGNALS ────
st.markdown('<hr class="gold-divider">', unsafe_allow_html=True)
st.subheader("Recent Signal Activity")
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
