#!/bin/bash
set -euo pipefail

echo "Preparing Flutter Web build..."

if ! command -v flutter >/dev/null 2>&1; then
  echo "Flutter SDK not found. Installing Flutter..."
  export FLUTTER_ROOT="$HOME/flutter"
  export PATH="$FLUTTER_ROOT/bin:$PATH"

  if [ ! -d "$FLUTTER_ROOT" ]; then
    git clone https://github.com/flutter/flutter.git --depth 1 -b stable "$FLUTTER_ROOT"
  fi
fi

flutter --version
flutter config --no-analytics
flutter precache --web
flutter pub get
flutter build web --release
