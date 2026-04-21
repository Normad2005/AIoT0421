Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "🏁 結束開發會期 (Ending Dev Session)" -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan

$CHANGE_NAME="c01-gecko-iot-habitat"
$DATE = Get-Date -Format "yyyy-MM-dd HH:mm"

# 1. 更新交接文件
Write-Host "📝 正在更新 handover.md..."
$Content = @"
# Project Handover - $DATE

## 目前開發狀態
透過自動化腳本更新於 $DATE。

### OpenSpec 任務狀態摘要
"@
$Content | Out-File -FilePath handover.md -Encoding utf8

# 獲取狀態並附加
& openspec.cmd status --change $CHANGE_NAME | Out-File -FilePath handover.md -Append -Encoding utf8

$AppendContent = @"

### 下一階段開發建議
- 繼續完成 tasks.md 中未勾選的硬體實作項目。
"@
$AppendContent | Out-File -FilePath handover.md -Append -Encoding utf8

# 2. 檢查是否可以歸檔 (Archive)
Write-Host "正在檢查是否可以歸檔 (Archive)..."
$StatusJson = & openspec.cmd status --change $CHANGE_NAME --json | ConvertFrom-Json
if ($StatusJson.isComplete -eq $true) {
    Write-Host "🎉 檢測到計畫已全數完成！執行歸檔..." -ForegroundColor Green
    & openspec.cmd archive $CHANGE_NAME
} else {
    Write-Host "ℹ️ 計畫尚未全數完成，跳過歸檔步驟。" -ForegroundColor Gray
}

# 3. Git 同步與推送
Write-Host "`n📤 正在將變更推送至 GitHub..." -ForegroundColor Yellow
git add .
git commit -m "Dev Sync: $DATE (Auto-commit via ending.ps1)"
git push origin main

Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "✅ 收尾完成！專案已同步回 GitHub。" -ForegroundColor Cyan
