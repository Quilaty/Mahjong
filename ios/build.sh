#!/usr/bin/env bash
# 建置 MahjongScore iOS App。
#
# 用法：
#   ./build.sh          只 build，確認能不能過（最快，不需要模擬器開機）
#   ./build.sh run      build 完裝進模擬器並啟動
#   ./build.sh run "iPhone 17 Pro"   指定模擬器機型（預設 iPhone 17）

set -euo pipefail
cd "$(dirname "$0")"

PROJECT="MahjongScore.xcodeproj"
SCHEME="MahjongScore"
BUNDLE_ID="tw.quilaty.mahjongscore"
MODE="${1:-build}"
DEVICE_NAME="${2:-iPhone 17}"

if ! command -v xcodegen >/dev/null 2>&1; then
  echo "找不到 xcodegen，先安裝：brew install xcodegen" >&2
  exit 1
fi

echo "==> xcodegen generate（依 project.yml 重新產生 ${PROJECT}）"
xcodegen generate

echo "==> xcodebuild build"
xcodebuild -project "$PROJECT" -scheme "$SCHEME" \
  -destination 'generic/platform=iOS Simulator' \
  build

if [ "$MODE" != "run" ]; then
  echo "==> Build 完成"
  exit 0
fi

echo "==> 尋找模擬器：${DEVICE_NAME}"
DEVICE_ID=$(xcrun simctl list devices available | grep -F "$DEVICE_NAME (" | grep -oE '[0-9A-F-]{36}' | head -1)
if [ -z "$DEVICE_ID" ]; then
  echo "找不到名為 \"$DEVICE_NAME\" 的模擬器，用 xcrun simctl list devices available 查可用機型" >&2
  exit 1
fi

APP_PATH=$(find ~/Library/Developer/Xcode/DerivedData -name "${SCHEME}.app" -path "*Debug-iphonesimulator*" -print0 \
  | xargs -0 ls -td 2>/dev/null | head -1)
if [ -z "$APP_PATH" ]; then
  echo "找不到 build 出來的 .app，DerivedData 路徑可能異常" >&2
  exit 1
fi

echo "==> 開機模擬器（若已開機會略過）"
xcrun simctl boot "$DEVICE_ID" 2>/dev/null || true
open -a Simulator --args -CurrentDeviceUDID "$DEVICE_ID"

echo "==> 安裝並啟動 App"
xcrun simctl install "$DEVICE_ID" "$APP_PATH"
xcrun simctl launch "$DEVICE_ID" "$BUNDLE_ID"

echo "==> 完成，App 已在「${DEVICE_NAME}」模擬器上啟動"
