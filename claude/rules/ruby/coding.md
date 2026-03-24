---
paths:
  - "**/*.rb"
  - "**/*.rake"
  - "**/Gemfile"
---

# Ruby コーディングルール

## スタイル

- インデントは2スペース
- メソッド名・変数名は `snake_case`
- クラス名・モジュール名は `PascalCase`
- 定数は `SCREAMING_SNAKE_CASE`
- 述語メソッドは `?` suffix（`empty?`, `valid?`）
- 破壊的メソッドは `!` suffix（`save!`, `update!`）

## メソッド

- メソッドは短く保つ。10行を超えたら分割を検討する
- 引数が3つ以上ならキーワード引数を使う
- `return` は早期リターン以外では省略する（最後の式が戻り値）
- ブロックは1行なら `{}` 、複数行なら `do...end`

## コレクション操作

- `each` でループせず `map`, `select`, `reject`, `reduce` を使う
- `&:method` のシンボルショートカットを活用する
- ネストした `map`/`select` は `flat_map` や `filter_map` で簡潔にする

## エラーハンドリング

- `rescue` は具体的な例外クラスを指定する。素の `rescue` は使わない
- カスタム例外は `StandardError` を継承する
- `retry` は回数制限をつける
- `ensure` でリソースのクリーンアップを保証する

## 避けること

- `method_missing` の安易な使用（デバッグ困難になる）
- モンキーパッチ（テスト以外）
- グローバル変数 `$` の使用
- 過度なメタプログラミング
