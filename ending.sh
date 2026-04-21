#!/bin/bash

# --- OpenSpec 收尾腳本 ---
# 功能：自動更新交接文檔、歸檔完成的變更、推送代碼至 GitHub

echo "=========================================="
echo "🏁 結束開發會期 (Ending Dev Session)"
echo "=========================================="

CHANGE_NAME="c01-gecko-iot-habitat"
DATE=$(date "+%Y-%m-%d %H:%M")

# 1. 更新交接文件
echo "📝 正在更新 handover.md..."
echo "# Project Handover - $DATE" > handover.md
echo "" >> handover.md
echo "## 目前開發狀態" >> handover.md
echo "透過自動化腳本更新於 $DATE。" >> handover.md
echo "" >> handover.md
echo "### OpenSpec 任務狀態摘要" >> handover.md
openspec status --change $CHANGE_NAME >> handover.md
echo "" >> handover.md
echo "### 下一階段開發建議" >> handover.md
echo "- 繼續完成 tasks.md 中未勾選的硬體實作項目。" >> handover.md

# 2. 檢查是否可以歸檔 (Archive)
# 讀取 JSON 狀態並檢查 isComplete 欄位
IS_COMPLETE=$(openspec status --change $CHANGE_NAME --json | grep '"isComplete": true')

if [ ! -z "$IS_COMPLETE" ]; then
    echo "🎉 檢測到計畫已全數完成！執行歸檔..."
    openspec archive $CHANGE_NAME
else
    echo "ℹ️ 計畫尚未全數完成，跳過歸檔步驟。"
fi

# 3. Git 同步與推送
echo ""
echo "📤 正在將變更推送至 GitHub..."
git add .
git commit -m "Dev Sync: $DATE (Auto-commit via ending.sh)"
git push origin main

echo "=========================================="
echo "✅ 收尾完成！專案已同步回 GitHub。"
echo "=========================================="
