---
paths:
  - "**/*.ts"
  - "**/*.tsx"
  - "**/*.test.ts"
  - "**/*.test.tsx"
  - "**/*.spec.ts"
  - "**/*.spec.tsx"
---

# TypeScript テストルール

## テスト構成

- テストファイルはソースと同じディレクトリに `.test.ts` / `.spec.ts` で配置する
- `describe` でテスト対象を、`it` で振る舞いを記述する
- 1つの `it` で1つのアサーション
- Arrange-Act-Assert パターンに従う

## 命名

```typescript
describe('UserService', () => {
  describe('findById', () => {
    it('returns user when found', () => { ... })
    it('throws NotFoundError when user does not exist', () => { ... })
  })
})
```

## Reactコンポーネントテスト

- Testing Libraryを使い、ユーザー操作に基づいてテストする
- 実装の詳細（state, props）ではなく、表示とインタラクションをテストする
- `getByRole`, `getByText` を優先する。`getByTestId` は最終手段
- 非同期処理は `waitFor` / `findBy` を使う

## モック

- 外部モジュールのみモックする。テスト対象の内部実装はモックしない
- `vi.mock` / `jest.mock` でモジュールレベルのモック
- APIレスポンスは MSW（Mock Service Worker）でインターセプトする
- モックは各テストでリセットする（`afterEach` で `vi.restoreAllMocks()`）

## 避けること

- スナップショットテストの過度な使用
- `setTimeout` / `sleep` による非同期待ち
- テスト間の状態共有・順序依存
