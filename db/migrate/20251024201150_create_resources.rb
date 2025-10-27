class CreateResources < ActiveRecord::Migration[8.0]
  def change
    create_table :resources do |t|
      t.string :title, null: false
      t.text :desc
      t.string :category, null: false
      t.string :url, null: false

      t.timestamps
    end
    add_index :resources, :category
  end
end
