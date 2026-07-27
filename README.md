# M-1Timer

Timer App vibrating per minute.

A watchOS timer for stand-up comedy and speeches: set a time limit, and the watch taps your wrist at a fixed interval so you can track your pace without looking down.

漫才・スピーチ用の watchOS タイマー。制限時間を設定しておくと、一定間隔で手首を振動させて経過を知らせるので、画面を見なくてもペースを把握できる。名前は M-1 グランプリに由来し、プリセットが 2 / 3 / 4 / 5 分なのもそのため。

## Features / 機能

- **Time limit** — presets of 2 / 3 / 4 / 5 minutes, or any custom duration
  **制限時間** — 2 / 3 / 4 / 5 分のプリセット、または任意の時間
- **Vibration interval** — haptic tap every N seconds until the limit is reached
  **通知間隔** — 制限時間に達するまで、N 秒ごとに手首を振動させる
- **Runs in the background** — keeps counting via `WKExtendedRuntimeSession` while your wrist is down
  **バックグラウンド継続** — `WKExtendedRuntimeSession` により腕を下ろしても計測が続く
- **English and Japanese** — localized via `M1Timer/Localizable.xcstrings`
  **英語・日本語対応** — `M1Timer/Localizable.xcstrings` で管理

## Requirements / 動作環境

- watchOS 9.0 or later / watchOS 9.0 以上
- Apple Watch only — there is no companion iPhone app
  Apple Watch 専用 — iPhone 側のアプリはない

## Build / ビルド

```
open M1Timer/M1Timer.xcodeproj
```

Select the **M1Timer Watch App** scheme and run.
スキーム **M1Timer Watch App** を選択して実行する。

## Project layout / 構成

```
M1Timer/
├── M1Timer.xcodeproj
├── Localizable.xcstrings          # en (source) + ja
├── M1Timer-Watch-App-Info.plist
└── M1Timer Watch App/             # all app code lives here
    ├── M1TimerApp.swift
    ├── ContentView.swift          # home screen
    ├── Path.swift                 # navigation routes
    ├── Timer/                     # running-timer screen
    └── Setting/                   # settings screens
```

## Roadmap / ロードマップ

Planned UI/UX improvements are tracked in [docs/ROADMAP.md](docs/ROADMAP.md).
UI/UX の改善計画は [docs/ROADMAP.md](docs/ROADMAP.md) にまとめてある。

## License / ライセンス

MIT — see [LICENSE](LICENSE).
