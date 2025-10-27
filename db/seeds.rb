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

# DevsheetCategoryのサンプルデータ
devsheet_category_data = [
  {
    name: "HTML",
    slug: "html",
    logo: "https://japdev.com/logos/html5.svg",
    description: "HTMLの基礎から応用まで",
    color: "#E34F26"
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

# JSONデータのインポート
fundamentals_json = [
  {
    slug: "basic-structure",
    title: "基本構造",
    description: "HTMLドキュメントの基本的な構造を学びましょう",
    codeBlocks: [
      {
        title: "基本的なHTMLテンプレート",
        language: "html",
        filename: "index.html",
        code: "<!DOCTYPE html>\n<html lang=\"ja\">\n<head>\n    <meta charset=\"UTF-8\">\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n    <title>ページタイトル</title>\n    <link rel=\"stylesheet\" href=\"styles.css\">\n</head>\n<body>\n    <h1>こんにちは、世界!</h1>\n    <p>これは基本的なHTMLページです。</p>\n    <script src=\"script.js\"></script>\n</body>\n</html>"
      }
    ]
  },
  {
    slug: "common-tags",
    title: "よく使うタグ",
    description: "頻繁に使用されるHTMLタグの例",
    codeBlocks: [
      {
        title: "見出しと段落",
        language: "html",
        filename: "headings.html",
        code: "<!-- 見出しタグ(h1〜h6) -->\n<h1>メインタイトル</h1>\n<h2>セクションタイトル</h2>\n<h3>サブセクション</h3>\n\n<!-- 段落と改行 -->\n<p>これは段落テキストです。</p>\n<p>改行するには<br>brタグを使います。</p>\n\n<!-- 順序なしリスト -->\n<ul>\n    <li>リスト項目 1</li>\n    <li>リスト項目 2</li>\n    <li>リスト項目 3</li>\n</ul>\n\n<!-- 順序付きリスト -->\n<ol>\n    <li>手順 1</li>\n    <li>手順 2</li>\n    <li>手順 3</li>\n</ol>",
        highlightLines: [ 2, 7, 11, 18 ]
      },
      {
        title: "リンクと画像",
        language: "html",
        filename: "links-images.html",
        code: "<!-- リンク -->\n<a href=\"https://example.com\">外部リンク</a>\n<a href=\"/about\">内部ページへのリンク</a>\n<a href=\"#section\">同じページ内のセクションへ</a>\n<a href=\"mailto:info@example.com\">メールリンク</a>\n\n<!-- 画像 -->\n<img src=\"image.jpg\" alt=\"画像の説明\">\n<img src=\"logo.png\" alt=\"ロゴ\" width=\"200\" height=\"100\">\n\n<!-- 図表 -->\n<figure>\n    <img src=\"chart.jpg\" alt=\"チャート\">\n    <figcaption>図1: 売上推移グラフ</figcaption>\n</figure>",
        highlightLines: [ 2, 8, 12 ]
      }
    ]
  },
  {
    slug: "forms",
    title: "フォーム",
    description: "フォーム要素とバリデーション",
    codeBlocks: [
      {
        title: "基本的なフォーム",
        language: "html",
        filename: "form.html",
        code: "<form action=\"/submit\" method=\"POST\">\n    <label for=\"name\">名前:</label>\n    <input type=\"text\" id=\"name\" name=\"name\" required>\n    \n    <label for=\"email\">メール:</label>\n    <input type=\"email\" id=\"email\" name=\"email\" required>\n    \n    <label for=\"message\">メッセージ:</label>\n    <textarea id=\"message\" name=\"message\" rows=\"4\"></textarea>\n    \n    <button type=\"submit\">送信</button>\n</form>",
        highlightLines: [ 1, 3, 6, 9, 11 ]
      }
    ]
  }
]

flexbox_json = [
  {
    slug: "flex-basics",
    title: "Flexboxの基本",
    description: "Flexboxレイアウトの基本的な使い方",
    codeBlocks: [
      {
        title: "基本的なFlexコンテナ",
        language: "html",
        filename: "flexbox-basic.html",
        code: "",
        tabs: [
          {
            label: "HTML",
            code: "<div class=\"flex-container\">\n    <div class=\"flex-item\">アイテム 1</div>\n    <div class=\"flex-item\">アイテム 2</div>\n    <div class=\"flex-item\">アイテム 3</div>\n</div>",
            language: "html"
          },
          {
            label: "CSS",
            code: ".flex-container {\n    display: flex;\n    justify-content: space-between;\n    align-items: center;\n    gap: 1rem;\n    padding: 1rem;\n    background: #f0f0f0;\n}\n\n.flex-item {\n    flex: 1;\n    padding: 1rem;\n    background: white;\n    border-radius: 8px;\n    box-shadow: 0 2px 4px rgba(0,0,0,0.1);\n}",
            language: "css"
          }
        ]
      },
      {
        title: "Flex方向とラッピング",
        language: "css",
        filename: "flex-direction.css",
        code: "/* 横並び(デフォルト) */\n.flex-row {\n    display: flex;\n    flex-direction: row;\n}\n\n/* 縦並び */\n.flex-column {\n    display: flex;\n    flex-direction: column;\n}\n\n/* 折り返しあり */\n.flex-wrap {\n    display: flex;\n    flex-wrap: wrap;\n    gap: 1rem;\n}\n\n/* 折り返しなし(デフォルト) */\n.flex-nowrap {\n    display: flex;\n    flex-wrap: nowrap;\n}",
        highlightLines: [ 2, 8, 14, 21 ]
      }
    ]
  },
  {
    slug: "flex-alignment",
    title: "配置とスペース",
    description: "要素の配置とスペース調整の方法",
    codeBlocks: [
      {
        title: "主軸と交差軸の配置",
        language: "css",
        filename: "flex-alignment.css",
        code: "/* 主軸方向の配置 */\n.justify-start {\n    display: flex;\n    justify-content: flex-start; /* 左揃え */\n}\n\n.justify-center {\n    display: flex;\n    justify-content: center; /* 中央揃え */\n}\n\n.justify-end {\n    display: flex;\n    justify-content: flex-end; /* 右揃え */\n}\n\n.justify-between {\n    display: flex;\n    justify-content: space-between; /* 両端揃え */\n}\n\n.justify-around {\n    display: flex;\n    justify-content: space-around; /* 均等配置 */\n}\n\n/* 交差軸方向の配置 */\n.align-start {\n    display: flex;\n    align-items: flex-start; /* 上揃え */\n}\n\n.align-center {\n    display: flex;\n    align-items: center; /* 中央揃え */\n}\n\n.align-end {\n    display: flex;\n    align-items: flex-end; /* 下揃え */\n}",
        highlightLines: [ 4, 9, 14, 19, 24, 30, 35, 40 ]
      }
    ]
  }
]

grid_json = [
  {
    slug: "grid-basics",
    title: "Gridの基本",
    description: "CSS Gridレイアウトの基礎",
    codeBlocks: [
      {
        title: "基本的なGridレイアウト",
        language: "html",
        filename: "GRID",
        code: "",
        tabs: [
          {
            label: "grid.html",
            code: "<div class=\"grid-container\">\n    <div class=\"grid-item\">1</div>\n    <div class=\"grid-item\">2</div>\n    <div class=\"grid-item\">3</div>\n    <div class=\"grid-item\">4</div>\n    <div class=\"grid-item\">5</div>\n    <div class=\"grid-item\">6</div>\n</div>",
            language: "html",
            title: "grid.html"
          },
          {
            label: "style.css",
            code: ".grid-container {\n    display: grid;\n    grid-template-columns: repeat(3, 1fr);\n    gap: 1rem;\n    padding: 1rem;\n}\n\n.grid-item {\n    padding: 2rem;\n    background: #e0e0e0;\n    border-radius: 8px;\n    text-align: center;\n}",
            language: "css"
          }
        ]
      }
    ]
  }
]

semantics_json = [
  {
    slug: "semantic-tags",
    title: "セマンティックタグ",
    description: "意味のあるHTMLタグを使用する",
    codeBlocks: [
      {
        language: "html",
        filename: "semantic.html",
        code: "<header>\n    <nav>\n        <ul>\n            <li><a href=\"/\">ホーム</a></li>\n            <li><a href=\"/about\">私たちについて</a></li>\n            <li><a href=\"/contact\">お問い合わせ</a></li>\n        </ul>\n    </nav>\n</header>\n\n<main>\n    <article>\n        <h1>記事タイトル</h1>\n        <p class=\"meta\">\n            <time datetime=\"2025-10-24\">2025年10月24日</time>\n            著者: 太郎\n        </p>\n        <p>記事の内容がここに入ります...</p>\n    </article>\n    \n    <aside>\n        <h2>関連情報</h2>\n        <ul>\n            <li><a href=\"#\">関連記事1</a></li>\n            <li><a href=\"#\">関連記事2</a></li>\n        </ul>\n    </aside>\n</main>\n\n<footer>\n    <p>&copy; 2025 会社名. All rights reserved.</p>\n</footer>",
        highlightLines: [ 1, 2, 8, 9, 11, 12, 19, 21, 27, 28, 30, 32 ]
      }
    ]
  }
]

# JSONデータを処理する
def process_json_data(topic_slug, json_data)
  topic = DevsheetTopic.find_by(slug: topic_slug)
  return unless topic

  json_data.each do |section_data|
    section = DevsheetSection.find_or_create_by(
      devsheet_topic_id: topic.id,
      slug: section_data[:slug]
    ) do |s|
      s.title = section_data[:title]
      s.description = section_data[:description]
    end

    section.update(
      title: section_data[:title],
      description: section_data[:description]
    )

    section_data[:codeBlocks].each do |block_data|
      has_tabs = block_data[:tabs].present?
      code_value = has_tabs ? "" : (block_data[:code] || "")

      code_block = DevsheetCodeBlock.find_or_initialize_by(
        devsheet_section_id: section.id,
        filename: block_data[:filename]
      )

      code_block.assign_attributes(
        title: block_data[:title],
        language: block_data[:language],
        code: code_value,
        highlight_lines: block_data[:highlightLines]
      )

      code_block.save!(validate: false)

      if has_tabs
        code_block.devsheet_code_block_tabs.destroy_all

        block_data[:tabs].each_with_index do |tab_data, index|
          code_block.devsheet_code_block_tabs.create!(
            label: tab_data[:label],
            code: tab_data[:code],
            language: tab_data[:language],
            title: tab_data[:title],
            position: index
          )
        end
      end
    end
  end
end

puts "📝 JSON データをインポート中..."

process_json_data("fundamentals", fundamentals_json)
puts "✅ Fundamentals: #{fundamentals_json.length}件のセクションを作成"

process_json_data("flexbox", flexbox_json)
puts "✅ Flexbox: #{flexbox_json.length}件のセクションを作成"

process_json_data("grid", grid_json)
puts "✅ Grid: #{grid_json.length}件のセクションを作成"

process_json_data("semantics", semantics_json)
puts "✅ Semantics: #{semantics_json.length}件のセクションを作成"

puts "📊 DevSheet最終統計:"
puts "  - カテゴリ: #{DevsheetCategory.count}件"
puts "  - トピック: #{DevsheetTopic.count}件"
puts "  - セクション: #{DevsheetSection.count}件"
puts "  - コードブロック: #{DevsheetCodeBlock.count}件"
puts "  - タブ: #{DevsheetCodeBlockTab.count}件"
puts "🎉 シード完了!"
