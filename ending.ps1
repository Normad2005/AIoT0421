Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "🏁 Ending Dev Session" -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan

$CHANGE_NAME="c01-gecko-iot-habitat"
$DATE = Get-Date -Format "yyyy-MM-dd HH:mm"

# 1. Update handover
Write-Host "📝 Updating handover.md..."
"# Project Handover - $DATE" | Out-File -FilePath handover.md -Encoding utf8
"Updated via automated script on $DATE." | Out-File -FilePath handover.md -Append -Encoding utf8
"" | Out-File -FilePath handover.md -Append -Encoding utf8
"### OpenSpec Status Summary" | Out-File -FilePath handover.md -Append -Encoding utf8

# Get status and append
& openspec.cmd status --change $CHANGE_NAME | Out-File -FilePath handover.md -Append -Encoding utf8

"" | Out-File -FilePath handover.md -Append -Encoding utf8
"### Next Steps" | Out-File -FilePath handover.md -Append -Encoding utf8
"- Continue with implementation in tasks.md." | Out-File -FilePath handover.md -Append -Encoding utf8

# 2. Archive if complete
Write-Host "Checking if ready to Archive..."
$StatusJson = & openspec.cmd status --change $CHANGE_NAME --json | ConvertFrom-Json
if ($StatusJson.isComplete -eq $true) {
    Write-Host "🎉 Plan complete! Archiving..." -ForegroundColor Green
    & openspec.cmd archive $CHANGE_NAME
} else {
    Write-Host "ℹ️ Plan not yet complete. Skipping archive." -ForegroundColor Gray
}

# 3. Git sync
Write-Host "`n📤 Pushing changes to GitHub..." -ForegroundColor Yellow
git add .
git commit -m "Dev Sync: $DATE (Auto-commit via ending.ps1)"
git push origin main

Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "✅ Done! Project synced to GitHub." -ForegroundColor Cyan
