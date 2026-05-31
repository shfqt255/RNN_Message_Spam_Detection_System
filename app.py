from fastapi import FastAPI

from pydantic import BaseModel
import pickle
import numpy as np
from tensorflow.keras.models import load_model
from tensorflow.keras.preprocessing.sequence import (
    pad_sequences
)
from fastapi.middleware.cors import CORSMiddleware



# load model
model = load_model(
    "spam_lstm_model.h5"
)

# load tokenizer
with open(
    "tokenizer.pkl",
    "rb"
) as file:

    tokenizer = pickle.load(file)

max_length = 171


# fastapi app
app = FastAPI()

app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


# request model
class MessageRequest(BaseModel):

    message: str


# root
@app.get("/")
def home():

    return {
        "message":
        "SMS Spam Detection API Running"
    }


# predict
@app.post("/predict")
def predict(
    request: MessageRequest
):

    text = request.message

    sequence = tokenizer.texts_to_sequences(
        [text]
    )

    padded = pad_sequences(
        sequence,
        maxlen=max_length,
        padding="pre",
    )

    prediction = model.predict(
        padded,
        verbose=0
    )[0][0]

    result = (
        "Spam"
        if prediction >= 0.5
        else "Not Spam"
    )

    print(prediction)

    return {
        "message": text,
        "prediction": result,
        "confidence": float(prediction)
    }