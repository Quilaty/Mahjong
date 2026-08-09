# 拍照辨識台數 — 訓練環境

麻將牌偵測模型的訓練用 Python 環境，與 `index.html`（網頁本體）、`ios/`（App 外殼）平級，彼此獨立。

對應規劃見 [`../docs/tile-recognition/DEVLOG.md`](../docs/tile-recognition/DEVLOG.md)。

## 環境

- Python 3.12，用 [uv](https://docs.astral.sh/uv/) 管理虛擬環境與套件（`pyproject.toml` / `uv.lock`）
- 框架：[Ultralytics YOLO](https://docs.ultralytics.com/)（PyTorch），訓練完可分別匯出 CoreML（iOS 原生）或 TFLite/TF.js（網頁），部署路徑尚未定案，兩邊都留著
- Apple Silicon 上會自動用 MPS 加速訓練/推論

## 使用方式

```bash
cd training
uv sync              # 安裝/同步套件到 .venv
uv run python -c "import torch; print(torch.backends.mps.is_available())"
```

之後所有指令都用 `uv run ...` 執行，會自動用這個專案的虛擬環境，不會動到系統 Python。

## 目錄

```
training/
├── datasets/     訓練/驗證用的麻將牌影像與標註（不進版控，太大）
├── weights/      訓練產出的模型權重（不進版控）
├── notebooks/    探索、視覺化用的 Jupyter notebook
└── scripts/      訓練、資料前處理、匯出模型等腳本
```

## 待辦（承接 DEVLOG 的下一步）

- [ ] 調查現成麻將牌偵測資料集，或規劃自行拍攝標註的流程
- [ ] 選定標註工具（YOLO 格式的 bounding box 標註，例如 Roboflow / LabelImg / CVAT）
- [ ] 決定辨識模型的執行位置（前端 TF.js vs. iOS CoreML），會影響匯出格式的優先順序
