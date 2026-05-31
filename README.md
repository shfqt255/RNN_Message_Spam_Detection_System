# AI Email Spam Detection System

An end-to-end Machine Learning project that detects whether an email or SMS message is **Spam** or **Not Spam** using Deep Learning. The project combines a TensorFlow/Keras LSTM model, a FastAPI backend, and a Flutter mobile application to provide real-time spam detection through an intuitive user interface.

---

# Overview

Spam messages remain one of the most common forms of unwanted communication across email and messaging platforms. This project leverages Recurrent Neural Networks (RNNs), specifically Long Short-Term Memory (LSTM) networks, to classify text messages based on their content.

Users can paste an email or SMS into the Flutter application, which communicates with a FastAPI server hosting the trained model. The server processes the text and returns a prediction along with a confidence score.

---

#  Features

* Deep Learning based spam detection
* Real-time prediction through API integration
* FastAPI backend for model serving
* Flutter mobile application
* Provider state management
* Confidence score reporting
* Clean and modern user interface
* Scalable architecture for future NLP models
* Supports both SMS and email content

---

# Machine Learning Pipeline

The model follows a complete Natural Language Processing workflow:

1. Text preprocessing
2. Tokenization
3. Vocabulary creation
4. Sequence generation
5. Sequence padding
6. Word embedding
7. LSTM-based classification
8. Binary prediction (Spam / ham)

The model is trained using TensorFlow/Keras and optimized using the Adam optimizer with Binary Cross-Entropy loss.

---

# Model Architecture

The spam detection model consists of:

* Embedding Layer
* LSTM Layer
* Dense Hidden Layer
* Dropout Regularization
* Sigmoid Output Layer

This architecture enables the network to learn contextual relationships between words and identify patterns commonly found in spam messages.

---

# Prediction Output

The system returns:

* Predicted Label

  * Spam
  * ham

* Confidence Score

  * Probability associated with the prediction

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

The mobile application provides:

* Multiline message input
* Real-time API communication
* Loading states
* Prediction results
* Confidence visualization
* Error handling
* Responsive Material Design interface

The application uses Provider for state management and communicates with the FastAPI backend using HTTP requests.

---

# FastAPI Backend

The backend is responsible for:

* Loading the trained LSTM model
* Loading the tokenizer
* Preprocessing incoming text
* Performing inference
* Returning prediction results as JSON

The API serves as the bridge between the Flutter frontend and the TensorFlow model.

---

# Technologies Used

### Machine Learning

* TensorFlow
* Keras
* NumPy
* Pandas
* Scikit-Learn

### Backend

* FastAPI
* Uvicorn
* Pydantic

### Mobile Application

* Flutter
* Provider
* HTTP Package

---

# Future Improvements

* Compare Simple RNN, LSTM, and GRU performance
* TensorFlow Lite integration for on-device inference
* Email subject analysis
* Multi-language spam detection
* Spam severity scoring
* Batch message processing
* Cloud deployment
* User prediction history

---

# Learning Outcomes

This project demonstrates practical implementation of:

* Natural Language Processing (NLP)
* Deep Learning for Text Classification
* Recurrent Neural Networks
* Long Short-Term Memory Networks (LSTM)
* API Development with FastAPI
* Flutter and Provider State Management
* Machine Learning Model Deployment

---

# License

This project is developed for educational and learning purposes and may be extended for research, portfolio, or production use.
