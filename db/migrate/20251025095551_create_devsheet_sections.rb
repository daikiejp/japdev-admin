class CreateDevsheetSections < ActiveRecord::Migration[8.0]
  def change
    create_table :devsheet_sections do |t|
      t.references :devsheet_topic, null: false, foreign_key: true
      t.string :title, null: false
      t.string :slug, null: false
      t.text :description

      t.timestamps
    end
  end
end
