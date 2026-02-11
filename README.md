# AI Plant Disease Detector 🌱

A super-intelligent, offline-capable AI system for detecting plant diseases in crops like cabbage, maize, tomato, and potato.

## Features
- **Multi-Crop & Multi-Disease Detection**: Identify diseases across various improved crop types.
- **Disease Severity Prediction**: Estimate percentage of leaf affected.
- **Grad-CAM Heatmaps**: Visualize infected areas.
- **Offline Mobile Support**: Optimized for low-resource Android devices using TensorFlow Lite.
- **Treatment Guidance**: Organic and chemical remedies.
- **Educational Mode**: Learn about disease lifecycles and prevention.

## Tech Stack
- **AI Model**: Python, TensorFlow/Keras, MobileNetV2.
- **Mobile App**: Flutter (Dart).
- **Backend/Data**: SQLite (local), Python scripts (training).

## Setup
1. **Model Training**: Run scripts in `model_training/` to train and convert the model.
2. **Mobile App**: unexpected open `mobile_app/` in Android Studio or VS Code and run `flutter run`.
