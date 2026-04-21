# Gecko IoT Habitat Monitoring System

基於 Arduino 與非阻塞式計時器架構的守宮棲息地智能監控系統。

## 專案目標
- **溫濕度監測**: 採用 DHT11，每 2 秒採樣一次。
- **光源追蹤**: 透過雙光敏電阻與伺服馬達，精準模擬自然光源角度。
- **非阻塞架構**: 使用 `Timer` 庫取代 `delay()`，支援多任務併行。
- **無線監控**: 透過 HC-06 藍牙模組上傳即時環境數據。

## 開發流程 (OpenSpec)
本專案採用 OpenSpec 規範驅動開發流程。
- **啟動開發**: `npm run dev:start` (或 `sh startup.sh`)
- **結束與交接**: `npm run dev:ending` (或 `sh ending.sh`)

## 快速開始
1. 安裝 OpenSpec CLI: `npm install -g @fission-ai/openspec`
2. 初始化環境: `openspec init`
3. 查看目前任務: `openspec status --change c01-gecko-iot-habitat`
