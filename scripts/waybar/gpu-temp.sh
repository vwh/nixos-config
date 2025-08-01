#!/usr/bin/env bash

temp=$(nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader)

if [ -z "$temp" ]; then
  echo "N/A"
else
  echo "$temp"
fi