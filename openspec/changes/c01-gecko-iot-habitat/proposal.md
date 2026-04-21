## Why

現有的 Arduino 專題往往依賴 `delay()` 指令進行定時操作，這會導致系統停擺，無法即時處理多任務併行。本專案旨在透過非阻塞式（Non-blocking）架構，精準監控守宮棲息地的溫濕度與模擬自然光源，並確保系統的高可靠性與擴充性。

## What Changes

- 導入 `Timer` 計時程式庫，取代所有 `delay()` 調用。
- 整合 DHT11 溫濕度感測器與雙光敏電阻光源追蹤系統。
- 建立以回呼函式（Callback function）驅動的多工任務調度。
- 透過 HC-06 藍牙模組實現環境數據的無線傳輸。

## Capabilities

### New Capabilities
- `habitat-telemetry`: 提供 2 秒間隔的溫濕度數據採集與發送功能。
- `solar-tracking`: 根據環境光源強度自動調整伺服馬達角度，模擬太陽運行軌道。
- `alarm-system`: 當環境參數（如溫度）超出安全閾值時觸發警報狀態。

### Modified Capabilities
<!-- No requirement changes to existing capabilities -->

## Impact

- **微控制器邏輯**: 從順序執行的忙碌等待轉向事件驅動的計時器架構。
- **通訊協定**: 定義了 0.5Hz 頻率的藍牙資料流格式。
- **物理硬體**: 包含 DHT11 的探樣限制（>2s）與伺服馬達的 PWM 抗震盪邏輯。
