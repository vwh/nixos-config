#!/usr/bin/env bash
set -euo pipefail

# Install global NPM packages
# Usage: ./install-global-packages.sh

PACKAGES=(
    "opencode-ai"
    "@google/gemini-cli"
)

echo "📦 Installing global NPM packages..."

# Check if bun is available
if ! command -v bun &> /dev/null; then
    echo "❌ Error: bun is not installed"
    exit 1
fi

for package in "${PACKAGES[@]}"; do
    echo "Installing $package..."
    if ! bun install -g "$package"; then
        echo "❌ Failed to install $package"
        exit 1
    fi
done

echo "✅ All packages installed successfully!"
