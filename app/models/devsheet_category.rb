class DevsheetCategory < ApplicationRecord
  has_many :devsheet_topics, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :slug, presence: true
  validates :color, format: { with: /\A#[0-9A-Fa-f]{6}\z/, message: "は有効なHEXカラーコードである必要があります" }, allow_blank: true

  before_validation :generate_slug, if: -> { slug.blank? && name.present? }

  # トピック数を取得
  def topics_count
    devsheet_topics.count
  end

  # JSONエクスポート用
  def to_export_hash
    {
      id: slug || name.downcase.gsub(" ", "-"),
      name: name,
      logo: logo,
      description: description,
      color: color,
      topicsCount: topics_count
    }
  end

  def generate_slug
    self.slug = name.downcase.gsub(" ", "-").gsub(/[^a-z0-9\-]/, "")
  end
end
