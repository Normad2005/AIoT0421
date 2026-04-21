#!/bin/bash

# --- OpenSpec Ending Script ---
# Update handover, archive complete changes, push to GitHub

echo "=========================================="
echo "🏁 Ending Dev Session"
echo "=========================================="

CHANGE_NAME="c01-gecko-iot-habitat"
DATE=$(date "+%Y-%m-%d %H:%M")

echo "📝 Updating handover.md..."
echo "# Project Handover - $DATE" > handover.md
echo "Updated via automated script on $DATE." >> handover.md
echo "" >> handover.md
echo "### OpenSpec Status Summary" >> handover.md
openspec status --change $CHANGE_NAME >> handover.md
echo "" >> handover.md
echo "### Suggested Next Steps" >> handover.md
echo "- Continue with items in tasks.md." >> handover.md

echo "Checking if ready to Archive..."
IS_COMPLETE=$(openspec status --change $CHANGE_NAME --json | grep '"isComplete": true')

if [ ! -z "$IS_COMPLETE" ]; then
    echo "🎉 Plan complete! Archiving..."
    openspec archive $CHANGE_NAME
else
    echo "ℹ️ Plan not yet complete. Skipping archive."
fi

echo ""
echo "📤 Pushing changes to GitHub..."
git add .
git commit -m "Dev Sync: $DATE (Auto-commit via ending.sh)"
git push origin main

echo "=========================================="
echo "✅ Done! Project synced to GitHub."
echo "=========================================="
