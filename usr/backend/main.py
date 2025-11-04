from datetime import datetime
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
from typing import List

class SignalModel(BaseModel):
    timestamp: datetime
    direction: str
    confidence: float

app = FastAPI()

# Enable CORS for all origins
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

@app.get("/api/signal", response_model=SignalModel)
async def get_signal(pair: str = 'EUR/USD', interval: str = '1m'):
    """
    Returns a stub BUY/SELL signal for the given pair and interval.
    """
    return SignalModel(
        timestamp=datetime.utcnow(),
        direction='UP',
        confidence=0.82
    )

@app.get("/api/history", response_model=List[SignalModel])
async def get_history(pair: str = 'EUR/USD', interval: str = '1m'):
    """
    Returns stub history of signals.
    """
    return [
        SignalModel(timestamp=datetime.utcnow(), direction='UP', confidence=0.82),
        SignalModel(timestamp=datetime.utcnow(), direction='DOWN', confidence=0.75)
    ]

@app.post("/api/train")
async def train_model():
    """
    Endpoint to trigger model retraining - stub implementation.
    """
    return {"status": "training_started"}
