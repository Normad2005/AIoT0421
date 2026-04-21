Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "🚀 啟動開發會期 (Startup Dev Session)" -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan

# 1. 同步雲端代碼
Write-Host "正在從 GitHub 獲取最新進度..."
git pull origin main

# 2. 顯示交接資訊
if (Test-Path "handover.md") {
    Write-Host "`n📋 前次開發交接紀錄 (Handover Document):" -ForegroundColor Yellow
    Write-Host "------------------------------------------"
    Get-Content handover.md
    Write-Host "------------------------------------------"
} else {
    Write-Host "⚠️ 找不到 handover.md，這可能是第一次啟動。" -ForegroundColor Red
}

# 3. 顯示目前變更計畫進度
Write-Host "`n🧩 目前 OpenSpec 變更計畫狀態 (Status):" -ForegroundColor Green
$CHANGE_NAME="c01-gecko-iot-habitat"
& openspec.cmd status --change $CHANGE_NAME

Write-Host "`n💡 建議後續行動 (Next Actions):" -ForegroundColor White
Write-Host "1. 檢查 openspec/changes/$CHANGE_NAME/tasks.md 中的待辦事項。"
Write-Host "2. 若準備好實作代碼，請在 Chat 中要求我執行任務。"
Write-Host "==========================================" -ForegroundColor Cyan
