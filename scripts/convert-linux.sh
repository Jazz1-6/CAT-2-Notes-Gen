#!/bin/bash
# Exam Notes Generator — Linux PDF conversion
# Usage: convert-linux.sh input.html output.pdf

set -e

if [ -z "$1" ] || [ -z "$2" ]; then
    echo "Usage: convert-linux.sh input.html output.pdf"
    exit 1
fi

INPUT="$(realpath "$1")"
OUTPUT="$(realpath -m "$2")"

BROWSER=""
for CANDIDATE in google-chrome google-chrome-stable chromium chromium-browser microsoft-edge microsoft-edge-stable; do
    if command -v "$CANDIDATE" >/dev/null 2>&1; then
        BROWSER="$CANDIDATE"
        break
    fi
done

if [ -z "$BROWSER" ]; then
    echo "Error: No compatible browser found."
    echo "Install one of: google-chrome, chromium, microsoft-edge"
    exit 1
fi

echo "Using $BROWSER..."
"$BROWSER" --headless=new --disable-gpu --print-to-pdf="$OUTPUT" --no-pdf-header-footer "file://$INPUT"

echo
echo "Output written to: $OUTPUT"