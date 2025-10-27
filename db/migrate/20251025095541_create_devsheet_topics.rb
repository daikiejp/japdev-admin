class CreateDevsheetTopics < ActiveRecord::Migration[8.0]
  def change
    create_table :devsheet_topics do |t|
      t.references :devsheet_category, null: false, foreign_key: true
      t.string :name, null: false
      t.string :slug, null: false
      t.text :description

      t.timestamps
    end

    add_index :devsheet_topics, [ :devsheet_category_id, :name, :slug ], unique: true
  end
end
