class DevsheetTopic < ApplicationRecord
  belongs_to :devsheet_category
  has_many :devsheet_sections, dependent: :destroy

  validates :name, presence: true
  validates :name, uniqueness: { scope: :devsheet_category_id }
  validates :slug, presence: true

  before_validation :generate_slug, if: -> { slug.blank? && name.present? }

  # JSONエクスポート用
  def to_export_hash
    {
      id: slug || name.downcase.gsub(" ", "-"),
      name: name,
      description: description
    }
  end

  private

  def generate_slug
    self.slug = name.downcase.gsub(" ", "-").gsub(/[^a-z0-9\-]/, "")
  end
end
