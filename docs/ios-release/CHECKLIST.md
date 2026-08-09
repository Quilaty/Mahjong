# iOS App Store 上架清單

盤點日期：2026-08-09。依目前 repo 實際狀態列出「已完成」與「還沒做」，之後每次推進就回來勾掉。

---

## 已完成

- [x] App 專案骨架（WKWebView 包裝 `index.html`），`ios/project.yml` 為唯一真實來源
- [x] App Icon（1024×1024、RGB、無 alpha channel，符合 App Store 規格；紅中牌造型，非佔位圖）
- [x] Bundle ID：`tw.quilaty.mahjongscore`
- [x] 顯示名稱：麻將計分
- [x] 版本號：Marketing 1.0 / Build 1
- [x] 僅支援直向、強制深色模式（`INFOPLIST_KEY_UIUserInterfaceStyle: Dark`）
- [x] 相機使用權限說明 `NSCameraUsageDescription`（拍照輔助功能用）
- [x] 本機建置腳本 `ios/build.sh`（build / 模擬器安裝執行）
- [x] deploymentTarget 16.4

## 還沒做

### 1. Apple Developer 帳號 / 憑證
- [ ] 確認有 Apple Developer Program 付費會員（年費 US$99），沒有的話要先申請
- [ ] Xcode 設定 Team、啟用 Automatic Signing，產生 Distribution Certificate + Provisioning Profile
- [ ] 在 [developer.apple.com](https://developer.apple.com) 註冊 `tw.quilaty.mahjongscore` 這個 Bundle ID（Identifiers 頁面手動註冊或讓 Xcode 自動建立）

### 2. App Store Connect 設定
- [ ] 建立新 App，綁定上面的 Bundle ID
- [ ] App 名稱、副標題、分類（建議 Utilities 工具程式，而非 Games，因為沒有遊戲邏輯只是計分）
- [ ] 年齡分級問卷 — **需要特別注意**：內容涉及「金錢輸贏計算」，問卷裡「模擬賭博 (Simulated Gambling)」選項要照實填，可能導致分級落在 12+ 或 17+，不填/亂填有被退件風險
- [ ] App 說明文案（可以直接從 `README.md` 的功能介紹改寫）
- [ ] 關鍵字、支援網址（Support URL，可用 GitHub repo 頁面）、行銷網址（可選）
- [ ] 聯絡資訊（Email）

### 3. 隱私權（App Store Connect 強制要求）
- [ ] **Privacy Policy URL** — 即使完全不收集資料也必須提供一個頁面。因為專案本身是 GitHub Pages 靜態站，最簡單的做法是在 repo 加一個 `privacy.html`（或 `PRIVACY.md` 用 GitHub Pages render）講清楚「所有資料只存在裝置本機 localStorage，不上傳、不收集、無第三方追蹤」，然後把它的 GitHub Pages 網址填進 App Store Connect
- [ ] App Privacy 問卷（Data Types Collected）— 如實填「不收集任何使用者資料」（本機 localStorage 不算「收集」，因為沒有離開裝置）
- [ ] 相機權限的隱私問卷欄位也要一併確認（雖然拍照只是本機預覽，沒有上傳）

### 4. 素材
- [ ] App Store 截圖（目前必要尺寸：6.9" 與 6.5" iPhone 至少各一組，5.5" 已非必填但保險起見可補）——目前完全沒有，需要用模擬器跑幾個畫面（開局設定、記分畫面、記錄本局、結算）截圖
- [ ] 宣傳圖 / App Preview 影片（選填，先跳過沒關係）

### 5. 送審合規（Xcode Archive 流程會問到）
- [ ] Export Compliance（加密使用聲明）— 這個 App 沒有自製加密，屬於標準豁免，Xcode 上傳時選「不使用/僅用系統標準加密」即可，不用額外文件
- [ ] Review 備註 — 沒有登入系統，不需要提供測試帳號，可在 App Review Information 裡註明「無需帳號，開啟即可使用」

### 6. ⚠️ 拍照功能需要先決定怎麼處理再送審
目前「拍照輔助（Beta）」只能拍照跟預覽，**不做任何辨識**，功能上等於「附加一張沒用的照片」。這種半成品功能有兩個風險：
- App Review 可能質疑相機權限的必要性（「這功能到底在幹嘛」）
- 對第一批使用者來說是無效功能，體驗上偷跑了 Beta 狀態

建議二選一：
- [ ] 選項A：正式送審前**先隱藏**這個入口（feature flag 或註解掉按鈕），等辨識功能真的做出來再開放，iOS 版先發一個沒有這功能的乾淨 1.0
- [ ] 選項B：保留但把文案改得更明確是「先拍照存底、之後才會有辨識」，降低審核疑慮，風險自負

### 7. 建置與上傳
- [ ] `xcodegen generate` 確認最新
- [ ] Xcode 裡 Archive（Product → Archive，需要用 Release scheme，`ios/build.sh` 目前只有 Debug/模擬器路徑，正式 Archive 建議直接用 Xcode GUI 操作比較不會踩坑）
- [ ] 透過 Xcode Organizer 或 Transporter App 上傳到 App Store Connect
- [ ] TestFlight 內部測試（強烈建議，先自己裝置測過一輪再送 App Review）
- [ ] 提交 App Review

### 8. 上架後
- [ ] 準備好 README 裡的下載連結替換/新增 App Store 連結
- [ ] 想清楚版本更新流程（`MARKETING_VERSION` / `CURRENT_PROJECT_VERSION` 怎麼遞增）

---

## 建議優先順序

1. 先決定拍照功能的去留（影響這次要不要送審）
2. 準備 Privacy Policy 頁面（卡關項，沒有它 App Store Connect 送不出去）
3. 確認 Apple Developer 帳號狀態
4. 截圖 + 文案 + 年齡分級問卷
5. TestFlight 測一輪
6. 正式送審
