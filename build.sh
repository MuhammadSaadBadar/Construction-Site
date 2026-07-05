#!/bin/bash
set -euo pipefail

echo "Preparing Flutter Web build..."

# Check if Flutter is installed
if ! command -v flutter >/dev/null 2>&1; then
  echo "Flutter SDK not found. Installing Flutter..."
  export FLUTTER_ROOT="$HOME/flutter"
  export PATH="$FLUTTER_ROOT/bin:$PATH"

  if [ ! -d "$FLUTTER_ROOT" ]; then
    git clone https://github.com/flutter/flutter.git --depth 1 -b stable "$FLUTTER_ROOT"
  fi
fi

# Ensure flutter is in PATH
export PATH="$HOME/flutter/bin:$PATH"

flutter --version
flutter config --no-analytics
flutter precache --web
flutter pub get

# ✅ ACTUALLY BUILD THE APP
flutter build web --release

echo "✅ Build completed! Output is in build/web/"