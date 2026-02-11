# Plant Disease Detector App

This is a Flutter application for detecting plant diseases offline using TensorFlow Lite.

## Prerequisites
- Flutter SDK (latest stable)
- Android Studio / VS Code
- Android Device (recommended) or Emulator

## Setup

1.  **Get Dependencies**:
    ```bash
    flutter pub get
    ```

2.  **Add the Model**:
    - Train your model using the Python scripts in `../model_training`.
    - Convert it to TFLite.
    - Rename the file to `model.tflite` and the labels to `labels.txt`.
    - Place them in `assets/models/`.
    *(Note: The app has mock logic if the model is not found, so you can run it immediately for UI testing)*

3.  **Run the App**:
    ```bash
    flutter run
    ```

## Features
- **Live Camera / Gallery**: Pick an image to analyze.
- **Diagnosis**: See disease name, confidence, and severity.
- **History**: Local SQLite database tracks all your scans.
- **Education**: Learn about diseases and take quizzes.
