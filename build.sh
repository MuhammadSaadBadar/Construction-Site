#!/bin/bash
set -euo pipefail

export FLUTTER_ROOT="$HOME/flutter"
export PATH="$FLUTTER_ROOT/bin:$PATH"

if [ ! -d "$FLUTTER_ROOT" ]; then
  echo "🚀 Installing Flutter..."
  git clone https://github.com/flutter/flutter.git --depth 1 -b stable "$FLUTTER_ROOT"
else
  echo "Flutter already installed."
fi

flutter --version
flutter config --no-analytics
flutter config --enable-web
flutter pub get

echo "🔨 Building Flutter web app..."
flutter build web --release --base-href "/"

echo "✅ Build complete!"