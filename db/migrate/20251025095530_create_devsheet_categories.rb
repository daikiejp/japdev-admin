class CreateDevsheetCategories < ActiveRecord::Migration[8.0]
  def change
    create_table :devsheet_categories do |t|
      t.string :name, null: false
      t.string :slug, null: false
      t.string :logo
      t.text :description
      t.string :color

      t.timestamps
    end

    add_index :devsheet_categories, [ :name, :slug ], unique: true
  end
end
