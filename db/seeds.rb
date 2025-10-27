# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
puts "🌱 データベースをシード中..."

# 記事のサンプルデータ
articles_data = [
  {
    title: "【結論】TypeScriptの型定義はtypeよりinterfaceを使うべき理由",
    source: "Zenn",
    url: "https://zenn.dev/bmth/articles/interface-props-extends",
    date: Date.new(2025, 10, 20),
    tags: [ "React", "TypeScript" ],
    image: "https://res.cloudinary.com/zenn/image/fetch/s--7Jje9Auw--/c_limit%2Cf_auto%2Cfl_progressive%2Cq_auto%2Cw_1200/https://storage.googleapis.com/zenn-user-upload/deployed-images/5724ca5e44b773e353d79b0b.png%3Fsha%3D67f6a03ec112c9e086b1d6dc5259f27f0e923cb9",
    description: "TypeScriptでコンポーネントのPropsやオブジェクトの型を定義するとき、typeとinterfaceのどちらを使うべきか、一度は悩んだことがあるのではないでしょうか。",
    author: "じょうげん"
  },
  {
    title: "アサヒビール停止で痛感：ランサムウェアは「工場」ではなく「業務フロー」を止める",
    source: "Qiita",
    url: "https://qiita.com/comty/items/e1f1f82b89278c1a7e8d",
    date: Date.new(2025, 10, 20),
    tags: [ "Security", "CSIRT", "ランサムウェア", "ゼロトラスト", "インシデント対応" ],
    image: "https://i.imgur.com/ku7fvhN.jpeg",
    description: "アサヒグループは2025年9月29日にサイバー攻撃があったと発表しました。",
    author: "こむてぃ"
  }
]

articles_data.each do |data|
  Article.find_or_create_by(url: data[:url]) do |article|
    article.title = data[:title]
    article.source = data[:source]
    article.date = data[:date]
    article.tags = data[:tags]
    article.image = data[:image]
    article.description = data[:description]
    article.author = data[:author]
  end
end

puts "✅ #{Article.count}件の記事を作成しました"

# リソースのサンプルデータ
resources_data = [
  {
    title: "DevDocs",
    desc: "開発者向けのドキュメントをまとめて検索できるサイト",
    category: "ドキュメント",
    url: "https://devdocs.io"
  },
  {
    title: "MDN Web Docs",
    desc: "Web技術の総合リファレンス",
    category: "ドキュメント",
    url: "https://developer.mozilla.org"
  },
  {
    title: "JavaScript.info",
    desc: "詳細なJavaScriptチュートリアル",
    category: "チュートリアル",
    url: "https://javascript.info"
  },
  {
    title: "FreeCodeCamp",
    desc: "無料プログラミングコース",
    category: "学習",
    url: "https://freecodecamp.org"
  },
  {
    title: "Stack Overflow",
    desc: "プログラミングQ&Aコミュニティ",
    category: "コミュニティ",
    url: "https://stackoverflow.com"
  },
  {
    title: "Qiita",
    desc: "開発者向けの技術記事共有サイト",
    category: "コミュニティ",
    url: "https://qiita.com"
  },
  {
    title: "Vercel",
    desc: "フロントエンド向けのクラウドデプロイサービス",
    category: "SaaS",
    url: "https://vercel.com"
  },
  {
    title: "Supabase",
    desc: "サーバーレスPostgreSQLデータベース",
    category: "SaaS",
    url: "https://supabase.com"
  }
]

resources_data.each do |data|
  Resource.find_or_create_by(url: data[:url]) do |resource|
    resource.title = data[:title]
    resource.desc = data[:desc]
    resource.category = data[:category]
  end
end

puts "✅ #{Resource.count}件のリソースを作成しました"

# バージョンのサンプルデータ（GitHub URLのみ指定）
versions_data = [
  {
    name: "React",
    repo_url: "https://github.com/facebook/react"
  },
  {
    name: "Next.js",
    repo_url: "https://github.com/vercel/next.js"
  },
  {
    name: "Vue",
    repo_url: "https://github.com/vuejs/core"
  },
  {
    name: "Astro",
    repo_url: "https://github.com/withastro/astro"
  },
  {
    name: "TypeScript",
    repo_url: "https://github.com/microsoft/TypeScript"
  },
  {
    name: "Node.js",
    repo_url: "https://github.com/nodejs/node"
  }
]

puts "🔄 GitHub APIからバージョン情報を取得中..."

 versions_data.each do |data|
  version = Version.find_or_initialize_by(name: data[:name])
  version.repo_url = data[:repo_url]
  version.fetch_from_github
  version.save
  puts "  ✓ #{data[:name]}: v#{version.version}"
 end

puts "✅ #{Version.count}件のバージョン情報を作成しました"
puts "🎉 シード完了！"

# DevsheetCategoryのサンプルデータ
devsheet_category_data = [
  {
    name: "HTML",
    slug: "html",
    logo: "https://japdev.com/logos/html5.svg",
    description: "HTMLの基礎から応用まで",
    color: "#E34F2620"
  }
]

devsheet_category_data.each do |data|
  DevsheetCategory.find_or_create_by(name: data[:name]) do |devsheet_category|
    devsheet_category.name = data[:name]
    devsheet_category.slug = data[:slug]
    devsheet_category.logo = data[:logo]
    devsheet_category.description = data[:description]
    devsheet_category.color = data[:color]
  end
end

puts "✅ #{DevsheetCategory.count}件のカテゴリを作成しました"
html_category = DevsheetCategory.find_by(name: "HTML")

# DevsheetTopicのサンプルデータ
devsheet_topic_data = [
  {
    name: "基礎",
    slug: "fundamentals",
    description: "HTMLの基本的な構造とタグ"
  },
  {
    name: "Flexbox",
    slug: "flexbox",
    description: "フレキシブルボックスレイアウト"
  },
  {
    name: "Grid",
    slug: "grid",
    description: "グリッドレイアウト"
  },
  {
    name: "セマンティック",
    slug: "semantics",
    description: "意味のあるHTMLタグ"
  }
]

devsheet_topic_data.each do |data|
  DevsheetTopic.find_or_create_by(name: data[:name]) do |devsheet_topic|
    devsheet_topic.devsheet_category_id = html_category.id
    devsheet_topic.name = data[:name]
    devsheet_topic.slug = data[:slug]
    devsheet_topic.description = data[:description]
  end
end

puts "✅ #{DevsheetTopic.count}件のトピックを作成しました"
