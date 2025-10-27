class CreateDevsheetCodeBlocks < ActiveRecord::Migration[8.0]
  def change
    create_table :devsheet_code_blocks do |t|
      t.references :devsheet_section, null: false, foreign_key: true
      t.string :title
      t.string :language
      t.string :filename
      t.text :code, null: false
      t.text :highlight_lines

      t.timestamps
    end
  end
end
