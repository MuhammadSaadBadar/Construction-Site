#!/bin/bash
set -e

echo "🚀 Installing Flutter..."

# Clone Flutter (CORRECTED)
git clone https://github.com/flutter/flutter.git --depth 1 -b stable

# Add Flutter to PATH
export PATH="$PATH:`pwd`/flutter/bin"

# Enable web support
flutter config --enable-web

# Get dependencies
flutter pub get

# Build the web app
echo "🔨 Building Flutter web app..."
flutter build web --release --base-href "/"

echo "✅ Build complete!"