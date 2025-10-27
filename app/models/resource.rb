class Resource < ApplicationRecord
  validates :title, presence: true
  validates :url, presence: true
  validates :category, presence: true

  CATEGORIES = [
    "ドキュメント",
    "チュートリアル",
    "学習",
    "ツール",
    "コミュニティ",
    "ブログ",
    "SaaS"
  ].freeze
end
