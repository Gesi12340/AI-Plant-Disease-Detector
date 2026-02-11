@echo off
echo ===============================================
echo      One-Time Git Setup for Plant Doctor
echo ===============================================
echo.
echo For first time push, GitHub needs to know who you are.
echo.

set /p email="Enter your GitHub Email: "
set /p name="Enter your GitHub Name: "

echo.
echo Configuring Git...
git config --global user.email "%email%"
git config --global user.name "%name%"

echo.
echo Committing files...
git add .
git commit -m "Initial commit of Plant Disease Detector"

echo.
echo Pushing to GitHub...
git branch -M main
git push -u origin main

echo.
echo ===============================================
echo                 SUCCESS!
echo ===============================================
pause
