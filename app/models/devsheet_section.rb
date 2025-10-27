class DevsheetSection < ApplicationRecord
  belongs_to :devsheet_topic
  has_many :devsheet_code_blocks, dependent: :destroy

  validates :title, presence: true
  validates :slug, presence: true

  accepts_nested_attributes_for :devsheet_code_blocks, allow_destroy: true

  before_validation :generate_slug, if: -> { slug.blank? && title.present? }

  # JSONエクスポート用
  def to_export_hash
    {
      id: slug || title.downcase.gsub(" ", "-"),
      title: title,
      description: description,
      codeBlocks: devsheet_code_blocks.map(&:to_export_hash)
    }
  end

  private

  def generate_slug
    self.slug = title.downcase.gsub(" ", "-").gsub(/[^a-z0-9\-]/, "")
  end
end
