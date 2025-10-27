# JapDev - 開発者向け情報管理システム

Ruby on Rails + Tailwind CSS + PostgreSQLで構築された、開発者向けの最新情報を管理するWebアプリケーションです。

## 🚀 機能

### 📝 記事管理

- 技術記事のCRUD操作
- タグ付け機能
- 画像サポート
- JSONエクスポート（`articles.json`）

### 🔄 バージョン管理

- フレームワーク/ライブラリのバージョン追跡
- **GitHub API自動連携**
  - リポジトリURLを入力するだけで最新情報を取得
  - ワンクリックで更新可能
  - スター数とリポジトリ説明を自動取得
- ステータス管理（新規/安定版/LTS）
- JSONエクスポート（`versions.json`）

### 📑 チートシート (DevSheet)

- カテゴリ、トピック、セクションの3階層構造
- コードブロック管理
- **タブ機能**: 複数ファイルを1つのコードブロックに
- Syntax highlighting対応
- JSONエクスポート（JSON形式）
- コピー機能付き

### 📚 リソース管理

- 開発リソースのCRUD操作
- カテゴリ別整理
- JSONエクスポート（`resources.json`）

## 📋 必要要件

- Ruby 3.2.0以上
- Rails 7.1.0以上
- PostgreSQL 13以上
- Node.js（Tailwind CSS用）

## 🛠️ セットアップ

### 1. リポジトリのクローン

```bash
git clone https://github.com/daikiejp/japdev-admin.git
cd japdev
```

### 2. 依存関係のインストール

```bash
bundle install
npm install
```

### 3. データベースのセットアップ

````bash
# .envを編集
```bash
PGHOST=localhost
PGPORT=5432
PGDATABASE=YOUR_DB
PGUSER=YOUR_USERNAME
PGPASSWORD=YOUR_PASSWORD
```

# データベース作成とマイグレーション

rails db:create
rails db:migrate

# サンプルデータ投入（オプション）

rails db:seed

````

### 4. GitHub API設定（オプション）

バージョン管理でGitHub APIのレート制限を増やすには：

```bash
# .envファイルを作成
echo "GITHUB_TOKEN=your_github_personal_access_token" > .env
```

### 5. サーバー起動

```bash
# 開発サーバー
bin/dev

# または
rails server
```

ブラウザで `http://localhost:3000` にアクセス

## 📦 主要機能の使い方

### 記事管理

1. `/articles` で記事一覧を表示
2. 「新規作成」ボタンで記事を追加
3. タグはカンマ区切りで入力（例: `React, TypeScript`）
4. 「JSONエクスポート」で `articles.json` をダウンロード

### バージョン管理

1. `/versions` でバージョン一覧を表示
2. 「新規作成」でGitHubリポジトリURLを入力
3. 保存時に自動的に最新リリース情報を取得
4. 「GitHub更新」ボタンで個別更新
5. 「全て更新」ボタンで一括更新

### チートシート

1. `/devsheet` でカテゴリ一覧を表示
2. カテゴリ作成 → トピック作成 → セクション作成の順で構築
3. セクション内でコードブロックを追加
4. 「+ タブ追加」で複数ファイルのコードを管理
5. 各レベルでJSONエクスポート可能

### リソース管理

1. `/resources` でリソース一覧を表示
2. カテゴリごとにグループ化されて表示
3. 「JSONエクスポート」で `resources.json` をダウンロード

## 🎨 UI/UX特徴

- **レスポンシブデザイン**: モバイルからデスクトップまで対応
- **グラデーション**: エメラルドグリーンからティールへの美しいグラデーション
- **ホバーエフェクト**: スムーズなトランジション効果
- **Tailwind CSS**: モダンなユーティリティファーストCSS
- **コピー機能**: コードを1クリックでコピー
- **タブUI**: 複数ファイルをタブで切り替え

## 📊 データ構造

### チートシート階層

```
DevsheetCategory (例: HTML, CSS, JavaScript)
  └── DevsheetTopic (例: 基礎, Flexbox, Grid)
      └── DevsheetSection (例: 基本構造, 配置とスペース)
          └── DevsheetCodeBlock
              └── DevsheetCodeBlockTab (複数可)
```

### JSONエクスポート形式

#### Categories

```json
{
  "id": "html",
  "name": "HTML",
  "logo": "https://...",
  "description": "HTMLの基礎から応用まで",
  "color": "#E34F26",
  "topicsCount": 4
}
```

#### Topics

```json
[
  {
    "id": "fundamentals",
    "name": "基礎",
    "description": "HTMLの基本的な構造とタグ"
  }
]
```

#### Sections (with Tabs)

```json
[
  {
    "id": "grid-basics",
    "title": "Gridの基本",
    "description": "CSS Gridレイアウトの基礎",
    "codeBlocks": [
      {
        "title": "基本的なGridレイアウト",
        "language": "html",
        "filename": "Grid",
        "code": "",
        "tabs": [
          {
            "label": "grid.html",
            "code": "...",
            "language": "html"
          },
          {
            "label": "style.css",
            "code": ".grid {...}",
            "language": "css"
          }
        ]
      }
    ]
  }
]
```

## 🔧 開発コマンド

```bash
# サーバー起動
rails server

# コンソール起動
rails console

# マイグレーション実行
rails db:migrate

# データベースリセット
rails db:reset

# ルート確認
rails routes

# テスト実行
rails test

# Linter実行
rubocop
erblint app/views/**/*.erb
```

## 🔑 環境変数

```bash
# .env
GITHUB_TOKEN=your_github_personal_access_token  # GitHub APIレート制限向上用（オプション）
```

## 📁 プロジェクト構造

```
japdev/
├── app/
│   ├── controllers/
│   │   ├── articles_controller.rb
│   │   ├── resources_controller.rb
│   │   ├── versions_controller.rb
│   │   ├── devsheet_categories_controller.rb
│   │   ├── devsheet_topics_controller.rb
│   │   └── devsheet_sections_controller.rb
│   ├── models/
│   │   ├── article.rb
│   │   ├── resource.rb
│   │   ├── version.rb
│   │   ├── devsheet_category.rb
│   │   ├── devsheet_topic.rb
│   │   ├── devsheet_section.rb
│   │   ├── devsheet_code_block.rb
│   │   └── devsheet_code_block_tab.rb
│   ├── services/
│   │   └── github_service.rb
│   └── views/
│       ├── layouts/
│       ├── articles/
│       ├── resources/
│       ├── versions/
│       ├── devsheet_categories/
│       ├── devsheet_topics/
│       └── devsheet_sections/
├── config/
│   ├── routes.rb
│   └── database.yml
├── db/
│   ├── migrate/
│   └── seeds.rb
└── public/
```

## 🤝 コントリビューション

1. このリポジトリをフォーク
2. フィーチャーブランチを作成 (`git checkout -b feature/amazing-feature`)
3. 変更をコミット (`git commit -m 'feat: add some amazing feature'`)
4. ブランチにプッシュ (`git push origin feature/amazing-feature`)
5. プルリクエストを作成

## 📝 ライセンス

[MITライセンス](LICENSE)

## 👨‍💻 作成者

ダニー・ダビラ（だいきえ）

- Website: [daikie.jp](https://daikie.jp)
- GitHub: [@daikiejp](https://github.com/daikiejp)

---

開発者の愛を込めて、開発者のために作られました。 💚
