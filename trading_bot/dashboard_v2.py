"""
TEKRA AI TRADER - Dashboard
XAUUSD AI Trading System Monitoring
"""
import streamlit as st
import pandas as pd
import numpy as np
import json
import os
from datetime import datetime, timedelta
import subprocess

st.set_page_config(page_title="Tekra AI Trader", page_icon="🪙", layout="wide")

# ──── PATHS ────
DATA_DIR = r"C:\TradingBot\data"
LOG_FILE = r"C:\TradingBot\bot.log"
MODEL_DIR = r"C:\TradingBot\models"
BACKTEST_DIR = r"C:\TradingBot\backtest"

# ──── STYLE ────
st.markdown("""
<style>
    .title-text { font-size:2.5rem; font-weight:700; 
        background:linear-gradient(90deg,#4caf50,#2196f3);
        -webkit-background-clip:text; -webkit-text-fill-color:transparent; }
    .metric-up { color:#4caf50; font-weight:bold; }
    .metric-down { color:#f44336; font-weight:bold; }
</style>
""", unsafe_allow_html=True)

# ──── HEADER ────
st.markdown("""
<div style="background:linear-gradient(135deg,#0d1b2a,#1b2838);padding:25px;border-radius:15px;text-align:center;margin-bottom:15px">
""", unsafe_allow_html=True)
c1,c2,c3=st.columns([1,2,1])
with c2:
    logo_path = r"C:\TradingBot\tekra_logo.png"
    if os.path.exists(logo_path):
        st.image(logo_path, width=220)
    st.markdown('<p style="text-align:center;font-size:1.2rem;color:#00bcd4;font-weight:600;margin-top:-10px">XAUUSD AI Trading System</p>', unsafe_allow_html=True)
st.markdown('</div>', unsafe_allow_html=True)
st.divider()

# ──── SIDEBAR ────
with st.sidebar:
    st.header(" System")
    result = subprocess.run(['tasklist','/FI','IMAGENAME eq python.exe'], capture_output=True, text=True)
    bot_on = 'python.exe' in result.stdout
    if bot_on:
        st.success(" BOT RUNNING")
    else:
        st.error(" BOT STOPPED")
    st.caption(f"Server: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')} WIB")
    st.divider()
    st.caption("Tekra AI Trader v1.0")

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

            st.subheader("Current Price")
            m1,m2,m3,m4,m5 = st.columns(5)
            m1.metric("XAUUSD", f"${last.get('close',0):.2f}")
            m2.metric("Spread", f"{last.get('spread',0)/0.01:.1f} pips")
            m3.metric("RSI (14)", f"{last.get('RSI',0):.1f}")
            m4.metric("ATR (14)", f"{last.get('ATR',0):.2f}")
            m5.metric("Vol", f"{last.get('tick_volume',0):.0f}")

            # Signal display
            ma_cross = last.get('MA_cross', 0)
            rsi_val = last.get('RSI', 50)
            if ma_cross == 1 and 30 < rsi_val < 70:
                st.success(f"###  BUY SIGNAL | Price: ${last['close']:.2f} | RSI: {rsi_val:.1f}")
            elif ma_cross == -1 and 30 < rsi_val < 70:
                st.error(f"###  SELL SIGNAL | Price: ${last['close']:.2f} | RSI: {rsi_val:.1f}")
            else:
                st.info("🔇 No active signal — monitoring market")

            # Charts
            c1,c2 = st.columns(2)
            with c1:
                st.subheader("Price (Today)")
                st.line_chart(df[['close']].tail(100), height=250)
            with c2:
                st.subheader("RSI (14)")
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
            st.info("Collecting data... bot running")
    else:
        st.warning(f"No data file yet: {csv_path}")

    st.caption("Refresh: Ctrl+R or F5")

# ──── TAB 2: BACKTEST ────
with tab2:
    st.subheader(" Backtest Performance")

    stats_path = f"{BACKTEST_DIR}\\stats_v3.json"
    if os.path.exists(stats_path):
        with open(stats_path) as f:
            stats = json.load(f)

        b1,b2,b3,b4 = st.columns(4)
        b1.metric("Net P&L", f"${stats.get('pnl',0):+,.2f}")
        b2.metric("Win Rate", f"{stats.get('win_rate',0):.1f}%")
        b3.metric("Profit Factor", f"{stats.get('profit_factor',0):.2f}")
        b4.metric("Max Drawdown", f"{stats.get('max_dd',0):.1f}%")

        b5,b6,b7,b8 = st.columns(4)
        b5.metric("Total Trades", stats.get('trades',0))
        b6.metric("Return", f"{stats.get('return_pct',0):+.1f}%")
        b7.metric("Avg Win", f"${stats.get('avg_win',0):+.2f}")
        b8.metric("Avg Loss", f"${stats.get('avg_loss',0):+.2f}")

        st.divider()
        st.subheader("Strategy Comparison")
        st.table({
            "Strategy": ["Manual Rules", "AI V2 (No SL/TP)", "AI V3 + SL/TP "],
            "Trades": ["220", "81", str(stats.get('trades','—'))],
            "Win Rate": ["41.4%", "59%", f"{stats.get('win_rate',0):.1f}%"],
            "P&L": ["-$7.68", "-$28.89", f"${stats.get('pnl',0):+,.2f}"],
            "Return": ["-0.1%", "-0.3%", f"{stats.get('return_pct',0):+.1f}%"],
            "Profit Factor": ["0.97", "—", f"{stats.get('profit_factor',0):.2f}"],
        })

        r1,r2 = st.columns(2)
        with r1:
            st.metric("TP Hits", stats.get('tp_hits',0))
        with r2:
            st.metric("SL Hits", stats.get('sl_hits',0))

    else:
        st.info("Backtest not yet run. Execute backtest_v3.py first.")

# ──── TAB 3: MODEL ────
with tab3:
    st.subheader(" AI Model Training")

    metrics_path = f"{MODEL_DIR}\\metrics_v2.json"
    if os.path.exists(metrics_path):
        with open(metrics_path) as f:
            m = json.load(f)

        acc = m.get('accuracy', 0) * 100
        k1,k2,k3,k4 = st.columns(4)
        k1.metric("Accuracy", f"{acc:.1f}%", delta=f"{acc-41:.0f}% vs manual")
        k2.metric("Precision", f"{m.get('best_precision',0)*100:.1f}%")
        k3.metric("Recall", f"{m.get('best_recall',0)*100:.1f}%")
        k4.metric("Best Threshold", f"{m.get('best_threshold',0):.2f}")

        d1,d2,d3,d4 = st.columns(4)
        ntr = m.get('n_train','—')
        nva = m.get('n_val','—')
        d1.metric("Train Samples", f"{ntr:,}" if isinstance(ntr,int) else str(ntr))
        d2.metric("Val Samples", f"{nva:,}" if isinstance(nva,int) else str(nva))
        d3.metric("Features", m.get('n_features','—'))
        d4.metric("Model", "XGBoost V2")

        model_file = f"{MODEL_DIR}\\xgboost_v2.pkl"
        if os.path.exists(model_file):
            mtime = datetime.fromtimestamp(os.path.getmtime(model_file))
            st.success(f" Model: `{model_file}`")
            st.caption(f"Last trained: {mtime.strftime('%Y-%m-%d %H:%M')}")

        # Features list
        if os.path.exists(f"{MODEL_DIR}\\features.json"):
            with open(f"{MODEL_DIR}\\features.json") as f:
                feats = json.load(f)
            with st.expander(f"Feature List ({len(feats)} features)"):
                st.code(", ".join(feats), language='text')

    else:
        st.info("Model not yet trained. Run train_v2.py.")

# ──── RECENT LOG ────
st.divider()
st.subheader(" Recent Activity")
if os.path.exists(LOG_FILE):
    with open(LOG_FILE) as f:
        lines = f.readlines()
    sigs = [l.strip() for l in lines if 'SIGNAL' in l or '>>>' in l]
    if sigs:
        for s in reversed(sigs[-10:]):
            if 'BUY' in s: st.success(s)
            elif 'SELL' in s: st.error(s)
            else: st.text(s)
    else:
        st.caption("No signals yet")
