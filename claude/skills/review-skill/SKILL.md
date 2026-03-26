---
name: review-skill
description: Claude Codeスキルを公式ベストプラクティスに基づいてレビューします。SKILL.mdファイルのレビュー、スキル品質のチェック、スキル構造の検証、改善提案が必要な場合に使用します。「このスキルをレビューして」「スキル品質をチェック」「SKILL.mdを検証」「このスキルを改善」などのリクエストで起動します。
argument-hint: "<path-to-skill-directory>"
---

# スキルレビュー

公式ベストプラクティスに基づいてスキルをレビューし、具体的な改善提案を行う。

## レビューワークフロー

### ステップ1: 対象スキルの特定

レビュー対象のSKILL.mdファイルを特定する:
- `$ARGUMENTS` でパスが指定されていればそれを使用
- 未指定の場合は `~/.claude/skills/` と `.claude/skills/` の両方からSKILL.mdを検索
- 複数のスキルが存在する場合はAskUserQuestionで確認

### ステップ2: 読み込みと分析

1. 対象のSKILL.mdファイルを完全に読み込む
2. [best-practices.md](references/best-practices.md) のチェックリストを読み込む
3. YAMLフロントマター（name, description等）を解析
4. ボディコンテンツの構造を分析

### ステップ3: ベストプラクティスとの照合

best-practices.md のチェックリストに沿って各カテゴリを評価する。
該当しないカテゴリ（Scripts、MCP Tools等）はスキップする。

### ステップ4: レビューレポート生成

以下の形式で結果をまとめる:

```markdown
# スキルレビューレポート: {skill-name}

## サマリー
- 総合評価: {PASS | NEEDS_IMPROVEMENT | CRITICAL_ISSUES}
- Critical: {件数}
- Warning: {件数}
- Info: {件数}

## Critical（必須修正）
{修正必須の問題をリスト}

## Warning（推奨修正）
{推奨される改善をリスト}

## Info（改善提案）
{オプションの強化をリスト}

## 具体的な推奨事項
{例を含む具体的なアクションアイテム}
```

### ステップ5: インタラクティブな改善

レポート提示後:
1. ユーザーに修正を希望するか確認
2. Critical問題を優先的に修正
3. 段階的に修正を適用
4. 各修正後に再検証

重大度分類は best-practices.md の Severity Levels セクションに従う。
