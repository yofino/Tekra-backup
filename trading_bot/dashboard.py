"""
TEKRA AI TRADER - Dashboard
Streamlit dashboard for XAUUSD trading bot monitoring
"""
import streamlit as st
import pandas as pd
import numpy as np
import json
import os
import time
from datetime import datetime, timedelta

st.set_page_config(
    page_title="Tekra AI Trader",
    page_icon="",
    layout="wide",
    initial_sidebar_state="expanded"
)

# ──── CONFIG ────
DATA_DIR = r"C:\TradingBot\data"
LOG_FILE = r"C:\TradingBot\bot.log"
MODEL_DIR = r"C:\TradingBot\models"
BACKTEST_DIR = r"C:\TradingBot\backtest"

# ──── STYLES ────
st.markdown("""
<style>
    .main > div { padding-top: 1rem; }
    .metric-card { background: #1a1a2e; padding: 20px; border-radius: 10px; text-align: center; margin: 5px; }
    .profit { color: #4caf50 !important; font-weight: bold; }
    .loss { color: #f44336 !important; font-weight: bold; }
    .neutral { color: #ff9800 !important; font-weight: bold; }
    .title { font-size: 2.5rem; font-weight: 700; background: linear-gradient(90deg, #4caf50, #2196f3); -webkit-background-clip: text; -webkit-text-fill-color: transparent; }
    .subtitle { font-size: 1rem; color: #888; }
    .signal-buy { background: #4caf50; padding: 5px 15px; border-radius: 5px; color: white; font-weight: bold; }
    .signal-sell { background: #f44336; padding: 5px 15px; border-radius: 5px; color: white; font-weight: bold; }
    .signal-hold { background: #666; padding: 5px 15px; border-radius: 5px; color: white; }
</style>
""", unsafe_allow_html=True)

# ──── HEADER ────
col1, col2, col3 = st.columns([1, 2, 1])
with col2:
    st.markdown('<p class="title"> TEKRA AI TRADER</p>', unsafe_allow_html=True)
    st.markdown('<p class="subtitle">XAUUSD Artificial Intelligence Trading System</p>', unsafe_allow_html=True)

st.divider()

# ──── SIDEBAR ────
with st.sidebar:
    st.header("Settings")
    refresh_rate = st.slider("Refresh (seconds)", 5, 60, 15)
    st.divider()

    st.header("Quick Stats")
    # Current time
    st.metric("Server Time", datetime.now().strftime("%Y-%m-%d %H:%M:%S"))

    # Bot status
    import subprocess
    result = subprocess.run(['tasklist', '/FI', 'IMAGENAME eq python.exe'], capture_output=True, text=True)
    bot_running = 'python.exe' in result.stdout
    if bot_running:
        st.success(" BOT RUNNING")
    else:
        st.error(" BOT STOPPED")

    st.divider()
    st.caption(f"Tekra AI Trader v1.0 | {datetime.now().strftime('%Y-%m-%d')}")

# ──── MAIN CONTENT ────
tab1, tab2, tab3, tab4 = st.tabs([" Live Market", " Backtest Results", " Model Training", " Trade Log"])

# ──── TAB 1: LIVE MARKET ────
with tab1:
    st.subheader("📡 Real-Time XAUUSD Monitoring")

    # Metrics row
    m1, m2, m3, m4, m5 = st.columns(5)

    # Load latest data from CSV
    today = datetime.now().strftime("%Y%m%d")
    csv_path = f"{DATA_DIR}\\xauusd_{today}.csv"

    if os.path.exists(csv_path):
        try:
            df = pd.read_csv(csv_path)
            if len(df) > 0:
                latest = df.iloc[-1]

                with m1:
                    price = latest.get('close', 0)
                    st.metric("XAUUSD", f"${price:.2f}")

                with m2:
                    rsi = latest.get('RSI', 0)
                    label = "RSI (14)"
                    st.metric(label, f"{rsi:.1f}")

                with m3:
                    spread = latest.get('spread', 0) / 0.01
                    st.metric("Spread", f"{spread:.1f} pips")

                with m4:
                    atr = latest.get('ATR', 0)
                    st.metric("ATR (14)", f"{atr:.2f}")

                with m5:
                    macd_h = latest.get('MACD_hist', 0)
                    st.metric("MACD Hist", f"{macd_h:.4f}")

                # Signal
                ma_cross = latest.get('MA_cross', 0)
                rsi_val = latest.get('RSI', 50)
                if ma_cross == 1 and 30 < rsi_val < 70:
                    st.markdown("""
                    <div style='background:#1b5e20;padding:20px;border-radius:10px;text-align:center;margin:10px 0'>
                        <h2 style='color:#4caf50'> BUY SIGNAL</h2>
                        <p>MA9 crossed ABOVE MA21 — Bullish momentum</p>
                    </div>""", unsafe_allow_html=True)
                elif ma_cross == -1 and 30 < rsi_val < 70:
                    st.markdown("""
                    <div style='background:#b71c1c;padding:20px;border-radius:10px;text-align:center;margin:10px 0'>
                        <h2 style='color:#f44336'> SELL SIGNAL</h2>
                        <p>MA9 crossed BELOW MA21 — Bearish momentum</p>
                    </div>""", unsafe_allow_html=True)
                else:
                    st.info("🔇 NO SIGNAL — Waiting for MA crossover setup")

                # Price chart (simple)
                if 'close' in df.columns and len(df) > 20:
                    st.subheader("Price Chart (Today)")
                    chart_data = df[['close', 'MA_9', 'MA_21']].tail(100)
                    if chart_data.shape[1] >= 1:
                        st.line_chart(chart_data, y=['close'])

                # Indicator panels
                c1, c2 = st.columns(2)
                with c1:
                    st.subheader("RSI (14)")
                    if 'RSI' in df.columns:
                        rsi_data = df[['RSI']].tail(50)
                        st.line_chart(rsi_data, height=200)
                with c2:
                    st.subheader("MACD")
                    if 'MACD' in df.columns:
                        macd_data = df[['MACD', 'MACD_signal']].tail(50)
                        st.line_chart(macd_data, height=200)

            else:
                st.warning("No data collected yet. Bot may have just started.")
        except Exception as e:
            st.error(f"Error loading data: {e}")
    else:
        st.info(f"Waiting for data... ({csv_path} not found)")

    # Auto-refresh
    time.sleep(refresh_rate)
    st.rerun()

# ──── TAB 2: BACKTEST RESULTS ────
with tab2:
    st.subheader(" Backtest Performance")

    stats_path = f"{BACKTEST_DIR}\\stats_v3.json"
    report_path = f"{BACKTEST_DIR}\\report_v3.txt"

    if os.path.exists(stats_path):
        with open(stats_path) as f:
            stats = json.load(f)

        # Summary cards
        b1, b2, b3, b4 = st.columns(4)
        with b1:
            pnl = stats.get('pnl', 0)
            color = "profit" if pnl > 0 else "loss"
            st.metric("Net P&L", f"${pnl:+,.2f}")
        with b2:
            st.metric("Win Rate", f"{stats.get('win_rate', 0):.1f}%")
        with b3:
            st.metric("Profit Factor", f"{stats.get('profit_factor', 0):.2f}")
        with b4:
            st.metric("Max Drawdown", f"{stats.get('max_dd', 0):.1f}%")

        b5, b6, b7, b8 = st.columns(4)
        with b5:
            st.metric("Total Trades", stats.get('trades', 0))
        with b6:
            st.metric("Return", f"{stats.get('return_pct', 0):+.1f}%")
        with b7:
            st.metric("Avg Win", f"${stats.get('avg_win', 0):+,.2f}")
        with b8:
            st.metric("Avg Loss", f"${stats.get('avg_loss', 0):+,.2f}")

        st.divider()

        # Comparison table
        st.subheader("Strategy Comparison")
        compare_data = {
            "Metric": ["Trades", "Win Rate", "P&L", "Return", "Profit Factor", "Max Drawdown", "R:R Ratio"],
            "Manual Rules": ["220", "41.4%", "-$7.68", "-0.1%", "0.97", "0.6%", "1.4"],
            "AI V2 (No SL/TP)": ["81", "59%", "-$28.89", "-0.3%", "—", "—", "—"],
            "AI V3 + SL/TP": [
                str(stats.get('trades', '—')),
                f"{stats.get('win_rate', 0):.1f}%",
                f"${stats.get('pnl', 0):+,.2f}",
                f"{stats.get('return_pct', 0):+.1f}%",
                f"{stats.get('profit_factor', 0):.2f}",
                f"{stats.get('max_dd', 0):.1f}%",
                f"{abs(stats.get('avg_win', 0) / stats.get('avg_loss', 0.01)):.1f}"
            ]
        }
        df_compare = pd.DataFrame(compare_data)
        st.dataframe(df_compare.set_index("Metric"), use_container_width=True)

        # TP vs SL breakdown
        st.subheader("Exit Analysis")
        tp_hits = stats.get('tp_hits', 0)
        sl_hits = stats.get('sl_hits', 0)
        chart_exit = pd.DataFrame({
            'Type': ['Take Profit', 'Stop Loss', 'Signal'],
            'Count': [tp_hits, sl_hits, stats.get('trades', 0) - tp_hits - sl_hits]
        })
        st.bar_chart(chart_exit.set_index('Type'), height=250)

    else:
        st.warning("No backtest results yet. Run training first.")

# ──── TAB 3: MODEL TRAINING ────
with tab3:
    st.subheader(" Model Training & Performance")

    metrics_path = f"{MODEL_DIR}\\metrics_v2.json"

    if os.path.exists(metrics_path):
        with open(metrics_path) as f:
            metrics = json.load(f)

        acc = metrics.get('accuracy', 0) * 100

        m1, m2, m3, m4 = st.columns(4)
        with m1:
            st.metric("Accuracy", f"{acc:.1f}%",
                     delta=f"{acc - 41:.0f}% vs manual",
                     delta_color="normal")
        with m2:
            prec = metrics.get('best_precision', 0) * 100
            st.metric("Precision", f"{prec:.1f}%")
        with m3:
            rec = metrics.get('best_recall', 0) * 100
            st.metric("Recall", f"{rec:.1f}%")
        with m4:
            st.metric("Best Threshold", f"{metrics.get('best_threshold', 0):.2f}")

        # Training details
        st.divider()
        st.subheader("Training Configuration")

        d1, d2, d3, d4 = st.columns(4)
        with d1:
            st.metric("Training Samples", f"{metrics.get('n_train', '—'):,}")
        with d2:
            st.metric("Validation Samples", f"{metrics.get('n_val', '—'):,}")
        with d3:
            st.metric("Features", metrics.get('n_features', '—'))
        with d4:
            st.metric("Scale Weight", f"{metrics.get('scale_pos_weight', 0):.1f}")

        # Model info
        model_path = f"{MODEL_DIR}\\xgboost_v2.pkl"
        if os.path.exists(model_path):
            st.success(f" Model saved: `{model_path}`")
            st.caption(f"Last trained: {datetime.fromtimestamp(os.path.getmtime(model_path)).strftime('%Y-%m-%d %H:%M')}")

        # Features used
        if os.path.exists(f"{MODEL_DIR}\\features.json"):
            with open(f"{MODEL_DIR}\\features.json") as f:
                features = json.load(f)
            st.subheader("Features Used")
            st.code("\n".join(features), language='text')

    else:
        st.info("Model not trained yet. Run train_v2.py first.")

# ──── TAB 4: TRADE LOG ────
with tab4:
    st.subheader(" Recent Signals & Activity")

    if os.path.exists(LOG_FILE):
        with open(LOG_FILE) as f:
            lines = f.readlines()

        # Filter only signal lines
        signals = [l for l in lines if 'SIGNAL' in l or '>>>' in l]

        if signals:
            st.caption(f"Last {min(len(signals), 50)} signals:")

            for s in reversed(signals[-50:]):
                s = s.strip()
                if 'BUY' in s:
                    st.markdown(f'<div class="signal-buy">{s}</div><br>', unsafe_allow_html=True)
                elif 'SELL' in s:
                    st.markdown(f'<div class="signal-sell">{s}</div><br>', unsafe_allow_html=True)
                else:
                    st.text(s)
        else:
            st.info("No signals yet. Bot is collecting data...")

        # Full log preview
        with st.expander("Full Log (last 100 lines)"):
            for l in reversed(lines[-100:]):
                st.text(l.strip())
    else:
        st.info("No log file yet.")
