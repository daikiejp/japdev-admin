class DevsheetCodeBlockTab < ApplicationRecord
  belongs_to :devsheet_code_block

  validates :label, presence: true
  validates :code, presence: true

  default_scope { order(:position) }
  #
  # JSONエクスポート用
  def to_export_hash
    hash = {
      label: label,
      code: code
    }

    hash[:language] = language if language.present?
    hash[:title] = title if title.present?

    hash
  end
end
