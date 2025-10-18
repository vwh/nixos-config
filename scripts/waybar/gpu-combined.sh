#!/usr/bin/env bash
# Combined GPU monitoring script for Waybar
# This script reduces nvidia-smi calls by getting both temp and usage in one call
# Output format for Waybar: {"text": " 65°C 󰍹 45%", "tooltip": "GPU Temp: 65°C\nGPU Usage: 45%"}

set -euo pipefail

# Get both GPU temperature and usage in a single nvidia-smi call
GPU_INFO=$(nvidia-smi --query-gpu=temperature.gpu,utilization.gpu --format=csv,noheader,nounits 2>/dev/null || echo "")

if [[ -n "$GPU_INFO" ]]; then
    # Parse the output (format: "65, 45")
    IFS=',' read -r TEMP USAGE <<< "$GPU_INFO"

    # Clean up whitespace
    TEMP=$(echo "$TEMP" | xargs)
    USAGE=$(echo "$USAGE" | xargs)

    # Validate values
    if [[ "$TEMP" =~ ^[0-9]+$ ]] && [[ "$USAGE" =~ ^[0-9]+$ ]]; then
        # Output in Waybar JSON format
        TEXT=" ${TEMP}°C 󰍹 ${USAGE}%"
        TOOLTIP="GPU Temp: ${TEMP}°C\nGPU Usage: ${USAGE}%"

        echo "{\"text\": \"$TEXT\", \"tooltip\": \"$TOOLTIP\"}"
    else
        # Fallback if parsing fails
        echo "{\"text\": \"GPU N/A\", \"tooltip\": \"GPU data unavailable\"}"
    fi
else
    # Fallback if nvidia-smi fails
    echo "{\"text\": \"GPU N/A\", \"tooltip\": \"GPU data unavailable\"}"
fi