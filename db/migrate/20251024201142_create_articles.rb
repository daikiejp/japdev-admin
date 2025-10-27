class CreateArticles < ActiveRecord::Migration[8.0]
  def change
    create_table :articles do |t|
      t.string :title, null: false
      t.string :source
      t.string :url, null: false
      t.date :date
      t.text :tags
      t.string :image
      t.text :description
      t.string :author

      t.timestamps
    end
    add_index :articles, :date
    add_index :articles, :source
  end
end
