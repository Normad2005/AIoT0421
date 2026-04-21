## ADDED Requirements

### Requirement: 溫度異常監測
系統必須（SHALL）持續比對當前溫度是否超過安全閾值（例如 32.0℃）。

#### Scenario: 觸發高溫警報
- **WHEN** 溫度讀數連續兩次超過 32.0℃
- **THEN** 系統狀態更新為 `HIGH_TEMP_ALERT` 並發送警報字串

### Requirement: 濕度異常監測
系統必須（SHALL）持續比對當前濕度是否低於安全閾值（例如 40%）。

#### Scenario: 觸發低濕警報
- **WHEN** 濕度讀數低於 40%
- **THEN** 系統狀態更新為 `LOW_HUMIDITY_ALERT` 並發送警報字串
