#!/usr/bin/env bash
set -euo pipefail

# Get network connection info for Waybar
# Usage: Called by Waybar

if ! command -v nmcli &> /dev/null; then
    echo "N/A"
    exit 0
fi

connection=$(nmcli -t -f NAME,TYPE connection show --active 2>/dev/null | head -n1)

if [[ -z "$connection" ]]; then
    echo "Disconnected"
    exit 0
fi

name=$(echo "$connection" | cut -d: -f1)
type=$(echo "$connection" | cut -d: -f2)

case "$type" in
    "802-3-ethernet") echo "LAN" ;;
    "802-11-wireless") echo "$name" ;;
    *) echo "$name" ;;
esac
