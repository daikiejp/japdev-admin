class DevsheetCodeBlock < ApplicationRecord
  belongs_to :devsheet_section
  has_many :devsheet_code_block_tabs, dependent: :destroy

  validates :language, presence: true
  validates :code, presence: true, unless: -> { devsheet_code_block_tabs.any? }

  serialize :highlight_lines, coder: JSON

  accepts_nested_attributes_for :devsheet_code_block_tabs, allow_destroy: true

  # 初期化
  after_initialize do
    self.highlight_lines ||= []
  end

  # highlight_linesを文字列から配列に変換
  before_save :parse_highlight_lines

  # JSONエクスポート用
  def to_export_hash
    hash = {
      language: language,
      filename: filename,
      code: code
    }

    hash[:title] = title if title.present?
    hash[:highlightLines] = highlight_lines if highlight_lines.present?

    if devsheet_code_block_tabs.any?
      hash[:tabs] = devsheet_code_block_tabs.order(:position).map(&:to_export_hash)
    end

    hash
  end

  private

  def parse_highlight_lines
    if highlight_lines.is_a?(String)
      # "1,2,3" o "1, 2, 3" → [1, 2, 3]
      self.highlight_lines = highlight_lines.split(",").map { |n| n.strip.to_i }.reject(&:zero?)
    elsif highlight_lines.nil?
      self.highlight_lines = []
    end
  end
end
