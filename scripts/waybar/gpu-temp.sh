#!/usr/bin/env bash
# Enhanced GPU temperature monitor for Waybar
# Supports NVIDIA, AMD, and Intel GPUs with multi-GPU detection
# Usage: Called by Waybar

set -euo pipefail

# Color codes for temperature warnings
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Temperature thresholds
WARNING_TEMP=70
CRITICAL_TEMP=85

get_nvidia_temp() {
    if ! command -v nvidia-smi &>/dev/null; then
        return 1
    fi

    # Get temperature for all GPUs
    local temps
    temps=$(nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader,nounits 2>/dev/null | tr '\n' ' ')

    if [[ -z "$temps" ]] || [[ "$temps" == "[Not Supported]" ]]; then
        return 1
    fi

    # Process temperatures
    local gpu_count=0
    local total_temp=0
    local max_temp=0

    for temp in $temps; do
        if [[ "$temp" =~ ^[0-9]+$ ]]; then
            total_temp=$((total_temp + temp))
            ((gpu_count++))
            if [[ $temp -gt $max_temp ]]; then
                max_temp=$temp
            fi
        fi
    done

    if [[ $gpu_count -eq 0 ]]; then
        return 1
    fi

    # Calculate average temp (currently unused but kept for potential future use)
    # local avg_temp=$((total_temp / gpu_count))

    # Color code based on temperature
    if [[ $max_temp -ge $CRITICAL_TEMP ]]; then
        echo -e "NVIDIA:${RED}${max_temp}°C${NC}"
    elif [[ $max_temp -ge $WARNING_TEMP ]]; then
        echo -e "NVIDIA:${YELLOW}${max_temp}°C${NC}"
    else
        echo "NVIDIA:${max_temp}°C"
    fi

    return 0
}

get_amd_temp() {
    if ! command -v rocm-smi &>/dev/null; then
        return 1
    fi

    local temp
    temp=$(rocm-smi --showtemp 2>/dev/null | grep "GPU" | head -1 | awk '{print $2}' | tr -d '°C')

    if [[ -z "$temp" ]] || ! [[ "$temp" =~ ^[0-9]+$ ]]; then
        return 1
    fi

    # Color code based on temperature
    if [[ $temp -ge $CRITICAL_TEMP ]]; then
        echo -e "AMD:${RED}${temp}°C${NC}"
    elif [[ $temp -ge $WARNING_TEMP ]]; then
        echo -e "AMD:${YELLOW}${temp}°C${NC}"
    else
        echo "AMD:${temp}°C"
    fi

    return 0
}

get_intel_temp() {
    if ! command -v sensors &>/dev/null; then
        return 1
    fi

    local temp
    temp=$(sensors 2>/dev/null | grep -i "gpu\|igpu" | head -1 | awk '{print $2}' | tr -d '+°C')

    if [[ -z "$temp" ]] || ! [[ "$temp" =~ ^[0-9]+$ ]]; then
        return 1
    fi

    # Color code based on temperature
    if [[ $temp -ge $CRITICAL_TEMP ]]; then
        echo -e "Intel:${RED}${temp}°C${NC}"
    elif [[ $temp -ge $WARNING_TEMP ]]; then
        echo -e "Intel:${YELLOW}${temp}°C${NC}"
    else
        echo "Intel:${temp}°C"
    fi

    return 0
}

# Try different GPU detection methods
if get_nvidia_temp; then
    exit 0
elif get_amd_temp; then
    exit 0
elif get_intel_temp; then
    exit 0
else
    echo "N/A"
    exit 0
fi