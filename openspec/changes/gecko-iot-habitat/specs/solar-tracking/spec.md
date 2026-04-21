## ADDED Requirements

### Requirement: 光源差值運算
系統必須（SHALL）讀取來自 A0 與 A1 引腳的光敏電阻類比數值，並計算其差值的絕對值。

#### Scenario: 差值計算
- **WHEN** 系統執行光照補償邏輯循環
- **THEN** 計算 `abs(Analog_A0 - Analog_A1)` 並儲存為 `light_diff`

### Requirement: 伺服馬達步進控制
當光強差值大於 10 時，伺服馬達必須（SHALL）根據強光方向偏轉 1 度，範圍限制在 0 至 180 度之間。

#### Scenario: 自動調整角度
- **WHEN** `light_diff` 大於 10 且當前角度未達極限
- **THEN** 伺服馬達向光照較強的一側轉動，直到差值小於閾值
