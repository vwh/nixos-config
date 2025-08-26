#!/usr/bin/env bash
# modules-check.sh - Check for missing module imports in Nix configurations
# This script validates that all .nix files in directories with default.nix are properly imported

set -euo pipefail

error_count=0

# Find all default.nix files in the project
mapfile -t defaults < <(find . -type f -name default.nix)

# Check each default.nix file for import consistency
for default in "${defaults[@]}"; do
  dir=$(dirname "$default")
  echo "⟳ Checking $default" >&2

  pushd "$dir" >/dev/null

  # Extract all relative imports from default.nix (e.g., ./module.nix)
  # Remove the "./" prefix to get just the filename
  mapfile -t imported < <(
    grep -oE '\./[^ ]+\.nix' default.nix | sed 's#\./##'
  )

  # Create a lookup table of imported modules for fast checking
  declare -A imp=()
  for m in "${imported[@]}"; do
    imp["$m"]=1
  done

  # Find all .nix files in current directory (excluding default.nix)
  mapfile -t locals < <(
    find . -maxdepth 1 -type f -name '*.nix' \
      ! -name default.nix -printf '%f\n'
  )

  # Check for .nix files that exist but aren't imported
  for f in "${locals[@]}"; do
    if [[ -z "${imp[$f]:-}" ]]; then
      echo "✗  Missing import: $dir/$f" >&2
      ((error_count++))
    fi
  done

  # Check for imports that point to non-existent files
  for m in "${imported[@]}"; do
    if [[ ! -f $m ]]; then
      echo "✗  Bad import (no such file): $dir/$m" >&2
      ((error_count++))
    fi
  done

  popd >/dev/null
done

# Report results and exit with appropriate status code
if (( error_count > 0 )); then
  echo "➤ Found $error_count import error(s)." >&2
  exit 1
else
  echo "➤ All imports OK!" >&2
  exit 0
fi