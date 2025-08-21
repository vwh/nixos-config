#!/usr/bin/env bash
set -euo pipefail

# Get GPU temperature for Waybar
# Usage: Called by Waybar

if ! command -v nvidia-smi &> /dev/null; then
    echo "N/A"
    exit 0
fi

temp=$(nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader 2>/dev/null)

if [[ -z "$temp" ]] || [[ "$temp" == "[Not Supported]" ]]; then
    echo "N/A"
else
    echo "${temp}°C"
fi