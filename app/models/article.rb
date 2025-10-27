class Article < ApplicationRecord
  validates :title, presence: true
  validates :url, presence: true

  # tagsをJSON形式で保存
  serialize :tags, coder: JSON

  # tagsをカンマ区切り文字列から配列に変換
  before_validation :parse_tags

  private

  def parse_tags
    if tags.is_a?(String)
      self.tags = tags.split(",").map(&:strip).reject(&:blank?)
    end
  end
end
