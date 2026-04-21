#!/bin/bash

# --- OpenSpec Startup Script ---
# Sync code, read handover, show progress

echo "=========================================="
echo "🚀 Startup Dev Session"
echo "=========================================="

echo "Syncing code from GitHub..."
git pull origin main

if [ -f "handover.md" ]; then
    echo ""
    echo "📋 Previous Handover Account:"
    echo "------------------------------------------"
    cat handover.md
    echo "------------------------------------------"
else
    echo "⚠️ handover.md not found. This might be the first start."
fi

echo ""
echo "🧩 Current OpenSpec Status:"
CHANGE_NAME="c01-gecko-iot-habitat"
openspec status --change $CHANGE_NAME

echo ""
echo "💡 Suggested Next Actions:"
echo "1. Check tasks.md in openspec/changes/$CHANGE_NAME/tasks.md"
echo "2. Run /opsx:apply in Chat to start implementation."
echo "=========================================="
