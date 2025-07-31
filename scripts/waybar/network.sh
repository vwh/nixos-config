#!/bin/sh

connection=$(nmcli -t -f NAME,TYPE connection show --active | head -n1)

if [ -z "$connection" ]; then
  echo "Disconnected"
  exit 0
fi

name=$(echo "$connection" | cut -d: -f1)
type=$(echo "$connection" | cut -d: -f2)

if [ "$type" = "802-3-ethernet" ]; then
  echo "LAN"
else
  echo "$name"
fi
