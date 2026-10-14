\
@echo off
echo Creating missing Flutter platform folders...
flutter create --platforms=android,ios,web .
if errorlevel 1 (
  echo Flutter platform generation failed. Make sure Flutter is installed and on PATH.
  pause
  exit /b 1
)
flutter pub get
pause
