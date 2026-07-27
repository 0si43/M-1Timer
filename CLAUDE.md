# CLAUDE.md

M-1 Timer は watchOS 専用の SwiftUI アプリ（漫才・スピーチ用タイマー）。概要とビルド方法は [README.md](README.md)、UI/UX の改善計画は [docs/ROADMAP.md](docs/ROADMAP.md) を参照。

## 構成

アプリコードは `M1Timer/M1Timer Watch App/` 配下にのみ存在する。Xcode ターゲットは 4 つ:

| ターゲット | 中身 |
|---|---|
| `M1Timer Watch App` | 実体。編集対象は原則ここ |
| `M1Timer` | 旧形式の watchApp2 コンテナ。ソースファイルを 1 つも持たない空の殻 |
| `M1Timer Watch AppTests` | Xcode テンプレートのスタブのみ |
| `M1Timer Watch AppUITests` | Xcode テンプレートのスタブのみ |

## コードの規約

コードから読み取れる既存の書き方。新しく書くときはこれに合わせる。

### ナビゲーション

`ContentView.swift:11` の `@State var path: [Path]` を唯一の真実として持ち、`@Binding` で全子 View に流す。ルートの定義は `Path.swift` の enum。

**画面を閉じるときは `@Environment(\.dismiss)` を使わず、`path` 配列を直接操作する**（現在 `\.dismiss` の使用箇所は 0）。`TimerView.end()` と `TimeIntervalSettingView.update()` が `path.firstIndex(of:)` + `path.remove(at:)` で自身を取り除いている。

### 永続化

`@AppStorage("TimeLimit")`（既定 120 秒）と `@AppStorage("VibrationInterval")`（既定 60 秒）を、必要な View ごとに都度宣言する。共有のストア型は無く、現在 3 ファイルに散在している。

### ローカライズ

正は `M1Timer/Localizable.xcstrings`（ソース言語 `en`、全 12 キーに `ja` 翻訳あり）。

参照は `String(localized: "Foo", defaultValue: "Foo")` の形が主流（`ContentView.swift` の `Text("Start")` / `Text("Setting")` だけが暗黙キー）。

**ユーザーに見える文字列を追加したら、`ja` 翻訳も必ず同時に入れる。**

### プレビュー

画面単位の View ファイルには必ず `#Preview` を付ける（現在 5 ファイル中 5 ファイル）。

## コミットメッセージ

英語 1 行、小文字始まりの短い記述。`added X` / `improved X` / `fixed X` の形が多い。Conventional Commits のプレフィックスは使っていない。
