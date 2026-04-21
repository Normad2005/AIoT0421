Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "🚀 Startup Dev Session" -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan

# 1. Sync code
Write-Host "Syncing code from GitHub..."
git pull origin main

# 2. Handover info
if (Test-Path "handover.md") {
    Write-Host "`n📋 Previous Handover Account:" -ForegroundColor Yellow
    Write-Host "------------------------------------------"
    Get-Content handover.md
    Write-Host "------------------------------------------"
} else {
    Write-Host "⚠️ handover.md not found." -ForegroundColor Red
}

# 3. Status
Write-Host "`n🧩 Current OpenSpec Status:" -ForegroundColor Green
$CHANGE_NAME="c01-gecko-iot-habitat"
& openspec.cmd status --change $CHANGE_NAME

Write-Host "`n💡 Suggested Next Actions:" -ForegroundColor White
Write-Host "1. Check tasks.md in openspec/changes/$CHANGE_NAME/tasks.md"
Write-Host "2. Run /opsx:apply in Chat to start implementation."
Write-Host "==========================================" -ForegroundColor Cyan
