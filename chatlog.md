# 守宮智能棲息地專案 - 開發對話紀錄 (Chat Log)

**日期**: 2026-04-21  
**專案路徑**: `c:\Users\user\0421`

---

## 1. 專案初始化與分析
- **請求**: 讀取 [dfn0519/IOT_proposal](https://github.com/dfn0519/IOT_proposal) 並生成規則書。
- **行動**: 
    - 分析了守宮棲息地的技術需求（DHT11, 光敏電阻, 伺服馬達, HC-06, Timer.h）。
    - 生成了基於 OpenAPI 3.0 的 [OpenAPI 規格書](file:///C:/Users/user/0421/gecko_iot_openapi_spec.md)。

## 2. 環境修復 (PowerShell Bug)
- **問題**: 系統權限限制導致無法加載 PowerShell 設定檔，報出 `UnauthorizedAccess / SecurityError`。
- **行動**: 執行 `Set-ExecutionPolicy RemoteSigned -Scope CurrentUser`。
- **結果**: 成功修復權限問題，指令執行回復正常。

## 3. OpenSpec 導入與規範建立
- **行動**: 
    - 安裝 `@fission-ai/openspec` 全域套件。
    - 初始化 OpenSpec 專案。
    - 設定命名規範：所有變更必須以 `c[二位編號]-` 開頭（例如 `c01-`）。
    - 建立了第一個變更計畫 [`c01-gecko-iot-habitat`](file:///C:/Users/user/0421/openspec/changes/c01-gecko-iot-habitat/)，包含：
        - `proposal.md` (提案)
        - `design.md` (技術設計)
        - `specs/` (詳細規格)
        - `tasks.md` (實作任務清單)

## 4. 基礎設施配置
- **Git 連接**: 將本地專案連接至 [Normad2005/AIoT0421](https://github.com/Normad2005/AIoT0421)。
- **基礎文件**: 建立並提交了 `README.md` 與 `handover.md`。

## 5. 自動化流程提案 (待實作)
- **提案**: 實作 `startup.sh` (啟動/拉取代碼/讀取交接) 與 `ending.sh` (收尾/存檔/推送)。
- **計畫狀態**: 已提交 [實作計畫](file:///C:/Users/user/.gemini/antigravity/brain/e4d5f688-3702-4077-bea3-9f0199a6ac60/implementation_plan.md) 等待核准。

---
*此紀錄由 Antigravity 自動生成，用於追蹤開發決策與環境變更。*
