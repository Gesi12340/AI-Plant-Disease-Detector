@echo off
echo Starting Plant Disease Model Training...
echo ========================================

cd /d "%~dp0"

echo 1. Installing dependencies...
python -m pip install -r requirements.txt
if %errorlevel% neq 0 (
    echo Error installing dependencies.
    pause
    exit /b %errorlevel%
)

echo.
echo 2. Starting Training (This may take 45+ minutes)...
python train_model.py --data_dir "../dataset_repo/raw/color" --epochs 20
if %errorlevel% neq 0 (
    echo Error during training.
    pause
    exit /b %errorlevel%
)

echo.
echo 3. Converting to TFLite...
python convert_tflite.py
if %errorlevel% neq 0 (
    echo Error during conversion.
    pause
    exit /b %errorlevel%
)

echo.
echo 4. Deploying to Mobile App...
copy "model.tflite" "..\mobile_app\assets\models\model.tflite"
copy "labels.txt" "..\mobile_app\assets\models\labels.txt"

echo.
echo ========================================
echo SUCCESS! Model trained and deployed.
echo You can now run the app:
echo cd ../mobile_app
echo flutter run
echo ========================================
pause
