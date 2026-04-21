#!/bin/bash

# --- OpenSpec 啟動腳本 ---
# 功能：拉取最新代碼、讀取交接文檔、顯示任務進度

echo "=========================================="
echo "🚀 啟動開發會期 (Startup Dev Session)"
echo "=========================================="

# 1. 同步雲端代碼
echo "正在從 GitHub 獲取最新進度..."
git pull origin main

# 2. 顯示交接資訊
if [ -f "handover.md" ]; then
    echo ""
    echo "📋 前次開發交接紀錄 (Handover Document):"
    echo "------------------------------------------"
    cat handover.md
    echo "------------------------------------------"
else
    echo "⚠️ 找不到 handover.md，這可能是第一次啟動。"
fi

# 3. 顯示目前變更計畫進度
echo ""
echo "🧩 目前 OpenSpec 變更計畫狀態 (Status):"
CHANGE_NAME="c01-gecko-iot-habitat"
openspec status --change $CHANGE_NAME

echo ""
echo "💡 建議後續行動 (Next Actions):"
echo "1. 檢查 openspec/changes/$CHANGE_NAME/tasks.md 中的待辦事項。"
echo "2. 若準備好實作代碼，請在 Chat 中要求我執行任務。"
echo "=========================================="
