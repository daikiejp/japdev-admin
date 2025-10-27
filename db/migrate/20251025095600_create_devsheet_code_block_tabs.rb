class CreateDevsheetCodeBlockTabs < ActiveRecord::Migration[7.1]
  def change
    create_table :devsheet_code_block_tabs do |t|
      t.references :devsheet_code_block, null: false, foreign_key: true
      t.string :label, null: false
      t.text :code, null: false
      t.string :language
      t.string :title
      t.integer :position, default: 0

      t.timestamps
    end

    add_index :devsheet_code_block_tabs, :position
  end
end
