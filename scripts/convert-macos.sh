#!/bin/bash
# Exam Notes Generator — macOS PDF conversion
# Usage: convert-macos.sh input.html output.pdf

set -e

if [ -z "$1" ] || [ -z "$2" ]; then
    echo "Usage: convert-macos.sh input.html output.pdf"
    exit 1
fi

INPUT="$(cd "$(dirname "$1")" && pwd)/$(basename "$1")"
OUTPUT_DIR="$(cd "$(dirname "$2")" 2>/dev/null && pwd)" || OUTPUT_DIR="$(pwd)"
OUTPUT="$OUTPUT_DIR/$(basename "$2")"

CHROME="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
EDGE="/Applications/Microsoft Edge.app/Contents/MacOS/Microsoft Edge"

if [ -x "$CHROME" ]; then
    BROWSER="$CHROME"
    echo "Using Google Chrome..."
elif [ -x "$EDGE" ]; then
    BROWSER="$EDGE"
    echo "Using Microsoft Edge..."
else
    echo "Error: Neither Chrome nor Edge found."
    echo "Install Google Chrome: https://www.google.com/chrome/"
    exit 1
fi

"$BROWSER" --headless=new --disable-gpu --print-to-pdf="$OUTPUT" --no-pdf-header-footer "file://$INPUT"

echo
echo "Output written to: $OUTPUT"