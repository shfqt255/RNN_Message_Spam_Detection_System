# RNN-Based SMS Spam Detection System

An end-to-end Deep Learning project that classifies SMS messages as **Spam** or **Ham** using Recurrent Neural Networks (RNNs). The project combines a TensorFlow/Keras LSTM model, a FastAPI backend, and a Flutter mobile application to provide real-time message classification through a modern user interface.

---

# Overview

Spam messages continue to be a major challenge in digital communication systems. This project explores the application of Recurrent Neural Networks for text classification by training a Long Short-Term Memory (LSTM) network on SMS messages.

The trained model learns sequential patterns within text and predicts whether a message belongs to the **Spam** or **Ham** category. Users can enter a message in the Flutter application, which communicates with a FastAPI backend hosting the trained model and returns the prediction along with a confidence score.

---

# Project Objectives

* Understand text classification using Recurrent Neural Networks.
* Compare the performance of Simple RNN, LSTM, and GRU architectures.
* Build a complete NLP pipeline from preprocessing to deployment.
* Deploy a trained RNN model through a REST API.
* Integrate Deep Learning predictions into a Flutter mobile application.

---

# Features

* SMS Spam/Ham classification
* Recurrent Neural Network-based architecture
* LSTM model for sequence learning
* FastAPI inference service
* Flutter mobile interface
* Provider state management
* Real-time predictions
* Confidence score reporting
* End-to-end deployment pipeline

---

# Dataset

The model is trained on the SMS Spam Collection dataset.

Categories:

* Spam
* Ham

Example:

Spam:

```text
Congratulations! You've won a free prize. Click here now.
```

Ham:

```text
Hey, are we still meeting tomorrow?
```

---

# Natural Language Processing Pipeline

The project implements the following NLP workflow:

1. Text preprocessing
2. Tokenization
3. Vocabulary construction
4. Sequence generation
5. Sequence padding
6. Word embeddings
7. Recurrent sequence learning
8. Binary classification

---

# Model Architecture

The implemented LSTM model consists of:

* Embedding Layer
* LSTM Layer
* Dense Layer
* Dropout Layer
* Sigmoid Output Layer

The architecture is designed to capture sequential dependencies in text and learn contextual patterns that distinguish spam messages from ham messages.

---

# Prediction Output

The API returns:

* Message
* Predicted Class

  * Spam
  * Ham
* Confidence Score

Example:

```json
{
  "message": "Congratulations! You won a free iPhone.",
  "prediction": "Spam",
  "confidence": 0.9845
}
```

---

# Flutter Application

The Flutter application provides:

* Message input screen
* API integration
* Loading states
* Prediction display
* Confidence reporting
* Error handling
* Responsive Material Design interface

Provider is used for state management and communication with the FastAPI backend.

---

# FastAPI Backend

The backend is responsible for:

* Loading the trained LSTM model
* Loading the tokenizer
* Converting text into sequences
* Applying sequence padding
* Running inference
* Returning predictions as JSON

---

# Technologies Used

## Deep Learning

* TensorFlow
* Keras
* NumPy

## Data Processing

* Pandas
* Scikit-Learn

## Backend

* FastAPI
* Uvicorn
* Pydantic

## Mobile Application

* Flutter
* Provider
* HTTP


---

# Learning Outcomes

This project demonstrates practical implementation of:

* Recurrent Neural Networks (RNNs)
* Long Short-Term Memory Networks (LSTMs)
* Sequence Modeling
* Natural Language Processing
* Text Classification
* Model Deployment with FastAPI
* Flutter and Provider Integration
* End-to-End Deep Learning Applications

---

# License

This project is intended for educational, research, and portfolio purposes.
