# 目錄結構

```
麻將/
├── index.html                     純 HTML/CSS/JS 單檔網頁本體，計分邏輯、UI、狀態持久化都在這裡，無外部依賴
├── README.md                      專案說明、功能介紹、使用方式
└── ios/                           iOS App 專案（WKWebView 包裝 index.html）
    ├── project.yml                xcodegen 設定檔，專案結構的唯一真實來源
    ├── MahjongScore.xcodeproj/    由 xcodegen 產生，不手動編輯；改動請編輯 project.yml 後重跑 `xcodegen generate`
    └── MahjongScore/
        ├── MahjongScoreApp.swift  App 進入點（SwiftUI @main）
        ├── ContentView.swift      WKWebView 外殼，載入專案根目錄的 index.html（引用同一份檔案，不複製）
        └── Assets.xcassets/       App Icon 等資源（App Icon 目前為佔位，上架前需補上實際圖示）
```

## 說明

- `index.html` 是唯一的資料來源（single source of truth），`ios/` 底下不會複製一份，`ContentView.swift` 直接透過相對路徑載入根目錄的 `index.html`，避免兩邊分岔。
- `ios/MahjongScore.xcodeproj` 是產生物，不會手動維護；要調整 iOS 專案設定（bundle id、build target、加檔案等）一律改 `ios/project.yml`，再執行 `xcodegen generate` 重新產生。
