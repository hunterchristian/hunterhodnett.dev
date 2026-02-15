#!/bin/bash
# Local dev server for hunterhodnett.ai
# Usage: ./dev.sh [port]

PORT=${1:-3333}

echo "Starting local server at http://localhost:$PORT"
echo "Press Ctrl+C to stop"
npx serve . -l "$PORT"
