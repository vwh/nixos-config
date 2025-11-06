#!/usr/bin/env bash

# Generate optimized file context report for ~/System/
# Excludes: .git, node_modules, __pycache__, .venv, and other unnecessary files

set -euo pipefail

OUTPUT_DIR="$HOME/System-file-context"
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
REPORT_FILE="$OUTPUT_DIR/system_file_context_optimized_$TIMESTAMP.txt"
INDEX_FILE="$OUTPUT_DIR/index_optimized_$TIMESTAMP.txt"

# Create output directory
mkdir -p "$OUTPUT_DIR"

echo "Generating OPTIMIZED file context report..."
echo "Output directory: $OUTPUT_DIR"
echo "Report file: $REPORT_FILE"
echo ""

# Start the report
cat > "$REPORT_FILE" << 'EOF'
# Optimized System File Context Report

This report contains all important files and their contents from ~/System/ directory.
Excludes: .git, node_modules, __pycache__, .venv, and other unnecessary directories.

Generated on:

EOF

# Add current date
date >> "$REPORT_FILE"

cat >> "$REPORT_FILE" << 'EOF'

## File Structure and Contents

EOF

# Create index
cat > "$INDEX_FILE" << 'EOF'
# Optimized System File Index

This file contains a searchable index of all important files in the ~/System/ directory.
Excludes: .git, node_modules, __pycache__, .venv, and other unnecessary directories.

## Directory Structure
EOF

# Function to check if file should be processed
should_process_file() {
    local file="$1"
    local relative_path="${file#"$HOME"/System/}"

    # Skip git directories and files
    if [[ "$relative_path" =~ ^\.git/ ]]; then
        return 1
    fi

    # Skip directories and files we don't need
    if [[ "$relative_path" =~ (node_modules|__pycache__|\.venv|target|dist|build|\.direnv|result|\.cache|\.pytest_cache|\.mypy_cache|site-packages|\.tox) ]]; then
        return 1
    fi

    # Skip common gitignore patterns and unnecessary files
    if [[ "$relative_path" =~ (\.gitignore$|\.gitmodules$|\.DS_Store$|Thumbs\.db$|\.log$|\.tmp$|\.cache$|\.swp$|\.swo$|\.pyc$|\.pyo$) ]]; then
        return 1
    fi

    # Skip files in common dependency directories
    if [[ "$relative_path" =~ (bun-types|typescript|undici-types|@types|pip|setuptools|wheel) ]]; then
        return 1
    fi

    # Skip binary files by extension
    if [[ "$relative_path" =~ \.(png|jpg|jpeg|gif|bmp|ico|svg|pdf|zip|tar|gz|bz2|xz|7z|rar|deb|rpm|exe|dll|so|dylib|bin|app|img|iso|dmg|pkg|msi|tdesktop-theme|theme|woff|woff2|ttf|otf|eot|mp3|mp4|avi|mov|mkv|flac|ogg|wav)$ ]]; then
        return 1
    fi

    return 0
}

# Function to process a file
process_file() {
    local file="$1"
    local relative_path="${file#"$HOME"/System/}"

    # Check if we should process this file
    if ! should_process_file "$file"; then
        return 0
    fi

    local file_size
    file_size=$(stat -f%z "$file" 2>/dev/null || stat -c%s "$file" 2>/dev/null || echo "0")

    # Add to index
    echo "- $relative_path ($file_size bytes)" >> "$INDEX_FILE"

    # Add to main report
    {
        echo ""
        echo "### File: $relative_path"
        echo "Size: $file_size bytes"
        echo "Last modified: $(stat -f%Sm -t%Y-%m-%d_%H:%M:%S "$file" 2>/dev/null || stat -c%y "$file" 2>/dev/null)"
        echo ""
        echo '```'
    } >> "$REPORT_FILE"

    # Add file content
    if [[ -f "$file" && -r "$file" ]]; then
        # Check if file is likely text/binary
        local file_type
    file_type=$(file -b "$file" 2>/dev/null || echo "unknown")

        # Only process if it's likely a text file
        if [[ "$file_type" =~ (text|ASCII|UTF-8|Unicode|empty|JSON|XML|YAML|script|data) ]] ||
           [[ "$relative_path" =~ \.(nix|sh|py|js|ts|json|yaml|yml|toml|md|txt|conf|cfg|ini|css|html|xml|rs|go|java|c|h|cpp|hpp|php|rb|pl|sql|dockerfile|justfile|makefile|gitignore|gitmodules|README|LICENSE|CHANGELOG|todo|lock)$ ]]; then

            if [[ $file_size -lt 1000000 ]]; then  # Less than 1MB
                if cat "$file" >> "$REPORT_FILE" 2>/dev/null; then
                    # Content added successfully
                    :
                else
                    echo "[Error reading file - may contain binary data]" >> "$REPORT_FILE"
                fi
            else
                echo "[File too large to display - $file_size bytes]" >> "$REPORT_FILE"
                echo "First 100 lines:" >> "$REPORT_FILE"
                head -100 "$file" >> "$REPORT_FILE" 2>/dev/null || echo "[Cannot read file]" >> "$REPORT_FILE"
            fi
        else
            echo "[Binary file skipped - type: $file_type]" >> "$REPORT_FILE"
        fi
    else
        echo "[File not readable or not a regular file]" >> "$REPORT_FILE"
    fi

    {
        echo '```'
        echo ""
        echo "---"
    } >> "$REPORT_FILE"
}

# Function to process directory recursively (excluding unnecessary directories)
process_directory() {
    local dir="$1"

    # Skip excluded directories completely
    local dir_relative="${dir#"$HOME"/System/}"
    if [[ -n "$dir_relative" ]] && [[ "$dir_relative" =~ (\.git|node_modules|__pycache__|\.venv|target|dist|build|\.direnv|result|\.cache|site-packages) ]]; then
        return 0
    fi

    echo "Processing directory: $dir"

    # Add directory to index
    if [[ -n "$dir_relative" ]]; then
        echo "" >> "$INDEX_FILE"
        echo "## Directory: $dir_relative" >> "$INDEX_FILE"
    fi

    # Process all items in directory, excluding unwanted paths
    while IFS= read -r -d '' item; do
        local item_relative="${item#"$HOME"/System/}"

        # Skip unwanted items
        if [[ "$item_relative" =~ (\.git|node_modules|__pycache__|\.venv|target|dist|build|\.direnv|result|\.cache|site-packages|bun-types|typescript|undici-types|@types) ]]; then
            continue
        fi

        if [[ -f "$item" ]]; then
            process_file "$item"
        elif [[ -d "$item" ]]; then
            # Add subdirectory to index
            echo "  - $item_relative/" >> "$INDEX_FILE"
        fi
    done < <(find "$dir" -maxdepth 1 -mindepth 1 -not -path '*/\.git*' -not -path '*/node_modules/*' -not -path '*/__pycache__/*' -not -path '*/.venv/*' -print0 | sort -z)

    # Recursively process subdirectories
    while IFS= read -r -d '' subdir; do
        local subdir_relative="${subdir#"$HOME"/System/}"

        # Skip unwanted subdirectories
        if [[ "$subdir_relative" =~ (\.git|node_modules|__pycache__|\.venv|target|dist|build|\.direnv|result|\.cache|site-packages|bun-types|typescript|undici-types|@types) ]]; then
            continue
        fi

        if [[ -d "$subdir" ]]; then
            process_directory "$subdir"
        fi
    done < <(find "$dir" -maxdepth 1 -mindepth 1 -type d -not -path '*/\.git*' -not -path '*/node_modules/*' -not -path '*/__pycache__/*' -not -path '*/.venv/*' -print0 | sort -z)
}

# Process the entire System directory
echo "Starting scan of ~/System/ (optimized - excluding node_modules, __pycache__, etc.)..."
process_directory "$HOME/System"

# Add summary to report
{
    echo ""
    echo "## Summary"
    echo "Total files processed: $(find "$HOME/System" -type f -not -path '*/\.git/*' -not -path '*/node_modules/*' -not -path '*/__pycache__/*' -not -path '*/.venv/*' | wc -l)"
    echo "Total directories: $(find "$HOME/System" -type d -not -path '*/\.git/*' -not -path '*/node_modules/*' -not -path '*/__pycache__/*' -not -path '*/.venv/*' | wc -l)"
    echo "Report generated on: $(date)"
} >> "$REPORT_FILE"

# Add summary to index
{
    echo ""
    echo "## Summary"
    echo "Total files (optimized): $(find "$HOME/System" -type f -not -path '*/\.git/*' -not -path '*/node_modules/*' -not -path '*/__pycache__/*' -not -path '*/.venv/*' | wc -l)"
    echo "Total directories (optimized): $(find "$HOME/System" -type d -not -path '*/\.git/*' -not -path '*/node_modules/*' -not -path '*/__pycache__/*' -not -path '*/.venv/*' | wc -l)"
    echo "Generated on: $(date)"
} >> "$INDEX_FILE"

# Create a compressed version for easy sharing
cd "$OUTPUT_DIR"
tar -czf "system_file_context_optimized_$TIMESTAMP.tar.gz" ./*.txt

echo ""
echo "✅ OPTIMIZED File context report generation complete!"
echo ""
echo "📁 Location: $OUTPUT_DIR"
echo "📄 Main report: $REPORT_FILE"
echo "📋 Index: $INDEX_FILE"
echo "📦 Compressed: $OUTPUT_DIR/system_file_context_optimized_$TIMESTAMP.tar.gz"
echo ""
echo "📊 Statistics:"
echo "   - Total files (optimized): $(find "$HOME/System" -type f -not -path '*/\.git/*' -not -path '*/node_modules/*' -not -path '*/__pycache__/*' -not -path '*/.venv/*' | wc -l)"
echo "   - Total directories (optimized): $(find "$HOME/System" -type d -not -path '*/\.git/*' -not -path '*/node_modules/*' -not -path '*/__pycache__/*' -not -path '*/.venv/*' | wc -l)"
echo "   - Report size: $(du -sh "$REPORT_FILE" | cut -f1)"
echo "   - Compressed size: $(du -sh "$OUTPUT_DIR/system_file_context_optimized_$TIMESTAMP.tar.gz" | cut -f1)"
echo ""
echo "🚀 OPTIMIZATIONS:"
echo "   - ✅ Skips .git directories and files"
echo "   - ✅ Skips node_modules and dependencies"
echo "   - ✅ Skips __pycache__, .venv, build artifacts"
echo "   - ✅ Shows content for ALL important files"
echo "   - ✅ Increased file size limit to 1MB"
echo "   - ✅ Focuses on your actual configuration and source code"
echo ""
echo "🎯 PERFECT FOR: AI analysis, code review, system documentation!"