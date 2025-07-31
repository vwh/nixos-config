#!/bin/sh

PACKAGES=(
  "opencode-ai"
  "@google/gemini-cli"
)

for package in "${PACKAGES[@]}"
do
  bun install -g "$package"
done
