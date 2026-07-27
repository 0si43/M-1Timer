# ROADMAP — UI/UX 改善計画

対象: M-1 Timer（watchOS 専用の漫才・スピーチ用タイマー）のユーザー体験。

結論: **最優先は `M1Timer/M1Timer Watch App/Timer/TimerView.swift` の作り直し。**
「残り時間が読めない」「進捗リングが情報を持たない」「停止できない」「常時表示が死んでいる」という 4 つの問題がこの 1 ファイルに同居しており、まとめて直すのが最も投資対効果が高い。

以下の指摘はすべて 2026-07-27 時点の `main`（`b6bc597`）の実コードを読んで確認したもの。行番号はその時点のもので、コードが動けばずれる。

---

## P1-A: タイマー画面の作り直し

`M1Timer/M1Timer Watch App/Timer/TimerView.swift`

### 残り時間ではなく経過分を表示し、しかも通知間隔ごとにしか更新されない

`TimerView.swift:22` は `Text(String(Int(passSeconds / 60)))`、すなわち**経過**分の切り捨て表示。
さらに `passSeconds` の加算は `TimerView.swift:54` にしかなく、これはバイブ用 `Timer` クロージャの内側である。既定の通知間隔 60 秒だと数字は 1 分間固まったまま `0 → 1 → 2` と飛ぶ。

舞台上で知りたいのは「あと何分何秒か」なので、ここが体験上の最大の乖離。

### 進捗リングに見えるが情報量がゼロ

`TimerView.swift:32-37` の破線サークルは 30 秒固定周期で回り続けるだけで、実際のタイマーの進行とは無関係。**進捗を表しているように見えて何も表していない**という、UI として最も避けたい状態になっている。

### 停止・一時停止の手段がない

`TimerView` にボタンが 1 つもなく、抜ける方法はシステムの戻るスワイプのみ。ネタが早く終わった・中断したいときの操作が存在しない。

### 常時表示（Always-On Display）が未対応

腕を下ろすとタイマーが暗い静止画で固まる。舞台上で使う道具としては本質的な欠落。

### `Timer.scheduledTimer` が壁時計に対して脆い

`TimerView.swift:52` の `Timer.scheduledTimer` は `Date` による突き合わせを持たないため、サスペンドやドリフトで実時間とずれる。

### 置き換えに使える API（現行 deployment target で利用可）

deployment target は watchOS 9.0（`WATCHOS_DEPLOYMENT_TARGET = 9.0`）。以下は watchOS SDK の `.swiftinterface` で availability を確認済み。

| API | availability |
|---|---|
| `Text(timerInterval:pauseTime:countsDown:showsHours:)` | watchOS 9.0+ |
| `ProgressView(timerInterval:countsDown:)` | watchOS 9.0+ |
| `EnvironmentValues.isLuminanceReduced` | watchOS 8.0+ |

前 2 つは `Timer` に依存せず毎秒カウントダウンし、常時表示中も更新され続ける。つまり「残り時間表示」「本物の進捗リング」「常時表示対応」「壁時計への脆さ」が同時に解消する。`isLuminanceReduced` は常時表示中に表示を簡略化したい場合に使う。

---

## P1-B: 実害のあるバグ

### 設定ピッカーが現在値を読み込まない

`M1Timer/M1Timer Watch App/Setting/TimeIntervalSettingView.swift:13-14` の `minute` / `second` が `appStorageValue` から初期化されていない。

- 開くと保存値にかかわらず常に `0 分 0 秒` を表示する
- ホイールを触らずに「設定」を押すと**間隔 0 秒が保存される**
- その状態で開始すると `TimerView.swift:52` が `Timer.scheduledTimer(withTimeInterval: 0, repeats: true)` になり暴走する

下限バリデーションも存在しない。UI の磨き込み以前に、まずここを塞ぐ。

### `WKExtendedRuntimeSession` に delegate が設定されていない

`M1Timer/M1Timer Watch App/Timer/ExtendedRuntimeSession.swift:15-18` の `startSession()` は `WKExtendedRuntimeSession()` を生成して `start()` を呼ぶだけで、`session.delegate = self` がない。

結果として同ファイル `25-34` の `WKExtendedRuntimeSessionDelegate` 実装と、`TimerView.swift:49` の `sessionEndCompletion` 配線は**丸ごとデッドコード**。OS がセッションを期限切れ・無効化しても、アプリは何も反応できない。

### 制限時間が通知間隔の整数倍でないと終了がずれる

`TimerView.swift:52-58` は通知間隔ごとにしか終了判定をしない。例えば制限 4 分 / 間隔 90 秒だと、判定は 90・180・270 秒でしか走らず 270 秒まで走って 30 秒超過する。

---

## P2: 画面の情報設計

### ホーム画面に現在の設定が出ない

`M1Timer/M1Timer Watch App/ContentView.swift:16-38` はアイコンボタン 2 つのみ。「いま何分に設定されているか」を確認するには設定画面まで潜る必要がある。スタートボタンの近くに「4 分 / 1 分ごと」を出すだけで、出番直前の確認コストが消える。

### 「デフォルトに戻す」が無言

`M1Timer/M1Timer Watch App/Setting/SettingView.swift:41-46` は 1 タップで即座に両方の値をリセットする。確認もフィードバックもない。

### タップ領域が小さい

`M1Timer/M1Timer Watch App/Setting/TimeIntervalSettingView.swift:39` の「設定」ボタンが `.controlSize(.mini)`。腕時計の画面では小さすぎる。

### 時間の書式が手組み

`M1Timer/M1Timer Watch App/Setting/SettingView.swift:70-79` の `displayTime(_:)` は文字列連結で組み立てており、末尾に半角スペースが残る。また 90 秒未満の値では「0 min」と表示される。ロケール対応の書式 API に寄せる。

### Digital Crown が使われていない

時間の設定という watchOS で最も Crown が自然な操作にホイールピッカーのみを使っている。

---

## P3: アクセシビリティ

現状、`accessibility` 系の記述がコードベースに **1 つも存在しない**。

- `ContentView.swift:18-37` のアイコンボタンには `accessibilityLabel` がなく、VoiceOver は「play」「gear」と読む。下に置かれた「スタート」「設定」の `Text` は別要素として分離しており、ボタンと結合されていない
- `TimerView.swift:23` の `.font(.system(size: 80))` は固定ポイント指定で、Dynamic Type に追従せず大きい設定では切れる
- `TimerView.swift:25-26` と `36-37` の無限ループアニメーションが `accessibilityReduceMotion` を見ていない。装飾でしかないリングに `.accessibilityHidden(true)` もない
- 完了通知がハプティクスのみで、視覚・聴覚の代替手段がない
- アクセシビリティ識別子がないため、UI テストターゲットから要素を指定できない

---

## P4: スコープを広げる施策

### Smart Stack ウィジェット / 文字盤コンプリケーション

文字盤側からタイマーを開始できるようにする。**watchOS 10 以上への引き上げが前提**。引き上げは休眠していた deprecation を一斉に起こしうるため、まず「引き上げ前後の警告件数を測る」ところから別タスクとして切る。

### 空のコンテナターゲットの整理

`M1Timer` ターゲット（`productType = "com.apple.product-type.application.watchapp2-container"`）はソースファイルを 1 つも持たない旧形式の殻。

### 定数・キーの重複

既定値 `120` / `60` が `ContentView.swift` `Setting/SettingView.swift` `Setting/TimeLimitSettingView.swift` に散在している。`@AppStorage` のキー文字列 `"TimeLimit"` / `"VibrationInterval"` も 3 ファイルに生文字列で重複している。

### デザイントークンの不在

`M1Timer/M1Timer Watch App/Assets.xcassets/AccentColor.colorset/Contents.json` は色値を持たない空のプレースホルダのまま。色（`.orange` `.cyan` `.gray`）・フォント・余白はすべて使用箇所にハードコードされている。

### テストが存在しない

`M1Timer Watch AppTests` / `M1Timer Watch AppUITests` はいずれも Xcode テンプレートのスタブのみ。

---

## 進め方の提案

P1-A（`TimerView` の作り直し）と P1-B の設定ピッカーの修正を 1 本目にまとめるのが効率的。`TimerView` を `Text(timerInterval:)` / `ProgressView(timerInterval:)` ベースに書き換える作業が、P1-A の 5 項目のうち 4 項目を同時に片付けるため。

P2・P3 はそれぞれ独立して小さく出せる。P4 は着手前に deployment target の判断が必要。
