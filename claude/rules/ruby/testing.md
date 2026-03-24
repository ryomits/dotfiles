---
paths:
  - "**/*.rb"
  - "**/*_spec.rb"
  - "**/*_test.rb"
---

# Ruby テストルール

## テストフレームワーク

- RSpecを優先する。minitestも可
- テストファイルは `spec/` にソースのディレクトリ構造をミラーして配置する

## RSpec スタイル

- `describe` はクラス名またはメソッド名（`#instance_method`, `.class_method`）
- `context` は条件を `when` / `with` / `without` で始める
- `it` は期待する振る舞いを簡潔に記述する
- 1つの `it` で1つのアサーション

```ruby
describe User, '#full_name' do
  context 'when first_name and last_name are present' do
    it 'returns concatenated name' do
      user = User.new(first_name: 'Taro', last_name: 'Yamada')
      expect(user.full_name).to eq('Taro Yamada')
    end
  end
end
```

## テストデータ

- `let` / `let!` でテストデータを遅延定義する
- FactoryBotを使う場合、必要最小限の属性だけ指定する
- `build` で済むなら `create` しない（DBアクセスを減らす）
- fixtureより factory を優先する

## モック

- 外部サービスのみモックする。内部実装はモックしない
- `allow` / `expect` で振る舞いを定義する
- WebMock / VCR でHTTPリクエストをスタブする

## 避けること

- テスト間の順序依存（各テストは独立して実行可能にする）
- `before` ブロックでの過度なセットアップ
- `sleep` を使った非同期待ち（適切なmatcher/retryを使う）
