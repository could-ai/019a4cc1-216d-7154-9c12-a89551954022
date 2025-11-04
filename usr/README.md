# AI Binary Signal Pro

This repository contains a Flutter front-end and a FastAPI backend for generating BUY/SELL signals for binary options trading using technical indicators and AI trend confirmations.

## Front-End (Flutter)

### Getting Started

1. Navigate to the root directory of the project.
2. Install dependencies:
   ```bash
   flutter pub get
   ```
3. Run the app:
   ```bash
   flutter run -d <device>
   ```

### Features

- Home Screen: Displays current pair, live signal direction, confidence, and countdown timer.
- Chart Screen: Placeholder for candlestick and indicator charts (RSI, MACD, EMA).
- History Screen: Lists past signals with timestamp and confidence.
- Settings Screen: Change candle interval (1m/5m) and toggle notifications.

## Backend (FastAPI)

### Getting Started

1. Navigate to the `backend` directory.
2. Install dependencies:
   ```bash
   pip install -r requirements.txt
   ```
3. Run the server:
   ```bash
   uvicorn main:app --reload --port 8000
   ```

### Endpoints

- `GET /api/signal?pair=<pair>&interval=<1m|5m>`: Returns the latest BUY/SELL signal.
- `GET /api/history?pair=<pair>&interval=<1m|5m>`: Returns a list of past signals.
- `POST /api/train`: Triggers retraining of the AI model (stub).

## Next Steps

- Implement chart rendering and indicator overlays using `charts_flutter` or another charting library.
- Integrate actual AI model for signal prediction and daily training.
- Add push notification support using Firebase or native services.
- Connect real market data sources for OHLCV updates.
