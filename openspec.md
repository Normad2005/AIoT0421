# 守宮智能棲息地監控系統 (Gecko IoT Habitat Monitoring System) - API 與通訊規則書

本文件根據 [dfn0519/IOT_proposal](https://github.com/dfn0519/IOT_proposal) 專案內容，將其感測器監控與硬體通訊邏輯轉換為標準化的 OpenAPI 規格 (OpenAPI Specification, OAS 3.0)。

> [!NOTE]
> 專案目前硬體端使用 HC-06 藍牙模組透過 Serial Port 發送字串資料。本規格書將此資料流抽象化為 RESTful API 的資料結構 (JSON Schema)，作為未來第二階段 (App Inventor 2 開發專屬手機 App 或伺服器後端) 的通訊協定與資料解析標準。

## 系統硬體與通訊限制

1. **資料更新頻率**：考量 DHT11 物理限制，資料採樣間隔必須大於 `2000ms` (更新頻率 <= 0.5Hz)。
2. **非阻塞設計 (Non-blocking)**：資料透過 Timer.h 進行排程發送，確保不干擾伺服馬達 (PWM) 的即時運算。
3. **資料內容**：包含環境溫度、濕度、以及根據光敏電阻運算的伺服馬達角度等狀態。

---

## OpenAPI 規格 (OAS 3.0.3)

以下為系統資料傳輸的 YAML 格式 OpenAPI 定義，可以直接匯入 Swagger UI 或 Postman 等工具進行檢視與測試。

```yaml
openapi: 3.0.3
info:
  title: Gecko IoT Habitat API (守宮智能棲息地監控系統 API)
  description: >
    基於 Arduino 與多重感測器的爬蟲類（守宮）智能環境監控與光源追蹤系統。
    此規格定義了由藍牙模組 (HC-06) 發送至終端設備 (如手機 App) 或後端伺服器的遙測資料結構。
  version: 1.0.0
  contact:
    name: IoT 開發團隊
    url: https://github.com/dfn0519/IOT_proposal
    
servers:
  - url: http://localhost:3000/api/v1
    description: 區域網路測試後端伺服器 (概念性)
  - url: ble://hc-06/telemetry
    description: 藍牙 HC-06 裝置 URI (概念性，代表藍牙 Serial 資料流)

paths:
  /telemetry:
    post:
      summary: 上傳感測器遙測數據 (Telemetry Upload)
      description: 由 Arduino 硬體端定時 (大於 2 秒) 封裝並發送至後端或行動裝置的環境讀數。
      operationId: uploadTelemetry
      requestBody:
        description: 包含溫濕度與馬達狀態的遙測資料
        required: true
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/TelemetryData'
      responses:
        '201':
          description: 數據接收並解析成功
        '400':
          description: 無效的數據格式或檢查碼錯誤
          
  /settings:
    get:
      summary: 獲取系統當前設定參數
      description: 獲取守宮棲息地系統目前的設定閾值（如光強差閾值、安全溫濕度範圍）。
      operationId: getSystemSettings
      responses:
        '200':
          description: 成功獲取設定
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/SystemSettings'

components:
  schemas:
    TelemetryData:
      type: object
      description: Arduino 傳送的整合感測器數據字串 (JSON 格式封裝)
      required:
        - temperature
        - humidity
        - motor_angle
      properties:
        timestamp:
          type: string
          format: date-time
          description: 端點接收或產生的時間戳記
        temperature:
          type: number
          format: float
          description: 環境溫度 (單位：攝氏 ℃)，由 DHT11 提供 (範圍 0~50℃)
          minimum: 0
          maximum: 50
          example: 28.5
        humidity:
          type: number
          format: float
          description: 環境濕度 (單位：相對濕度 %)，由 DHT11 提供 (範圍 20~90%)
          minimum: 20
          maximum: 90
          example: 65.0
        motor_angle:
          type: integer
          description: 伺服馬達當前偏轉角度 (單位：度)，用以模擬光源角度
          minimum: 0
          maximum: 180
          example: 90
        light_diff:
          type: integer
          description: 左/右兩側光敏電阻分壓後轉換的類比數值差值 (A0/A1 讀數之差)
          example: 15
        system_status:
          type: string
          description: 系統運行狀態標籤
          enum:
            - NORMAL
            - HIGH_TEMP_ALERT
            - LOW_HUMIDITY_ALERT
          example: NORMAL

    SystemSettings:
      type: object
      description: 系統運行用的保護與判定閾值
      properties:
        temp_high_alert:
          type: number
          format: float
          description: 溫度過高警報閾值 (℃)
          example: 32.0
        humidity_low_alert:
          type: number
          format: float
          description: 濕度過低警報閾值 (%)
          example: 40.0
        light_jitter_threshold:
          type: integer
          description: 避免伺服馬達震盪 (Jitter) 的光源差值閾值，差值大於此值才轉動馬達
          example: 10
        sensor_poll_interval_ms:
          type: integer
          description: 感測器讀取頻率 (必須 >= 2000 ms)
          example: 2000
```

## 應用建議 (藍牙字串映射)

在實際 Arduino 的 C++ 實作中，若受限於 JSON 函式庫體積，通常會以簡單的 CSV (逗號分隔) 或特定符號建立字串。
建議 Arduino 端的 `Serial.print` 輸出格式符合下方結構，以利手機 APP (App Inventor 2) 解析並對應上述 OpenAPI 之 Schema：

**格式範例傳輸指令**：
`TEL:28.5,65.0,90,15,NORMAL\n`

*解析對應 (由 App Inventor 的 Split Text 以逗號切分)*：
1. `TEL:` 表頭標籤，代表這是一串遙測資料 (Telemetry)
2. `[0]` 28.5 -> `temperature`
3. `[1]` 65.0 -> `humidity`
4. `[2]` 90 -> `motor_angle`
5. `[3]` 15 -> `light_diff`
6. `[4]` NORMAL -> `system_status`
