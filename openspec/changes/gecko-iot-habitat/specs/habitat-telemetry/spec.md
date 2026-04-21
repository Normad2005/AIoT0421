## ADDED Requirements

### Requirement: 定時資料採集
系統必須（SHALL）每隔 2000 毫秒由 DHT11 感測器讀取一次環境溫度與濕度數據。

#### Scenario: 成功採樣
- **WHEN** 計時器達到 2000 毫秒週期
- **THEN** 系統成功讀取 DHT11 數據並更新內部變量

### Requirement: 數據格式發送
系統必須（SHALL）將溫度、濕度、馬達角度與系統狀態封裝為 `TEL:` 開頭的 CSV 字串並透過藍牙發送。

#### Scenario: 數據上傳
- **WHEN** 感測器數據更新完成
- **THEN** 藍牙模組發送如下字串：`TEL:<Temp>,<Humid>,<Angle>,<Diff>,<Status>\n`
