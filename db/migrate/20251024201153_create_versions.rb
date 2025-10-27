class CreateVersions < ActiveRecord::Migration[8.0]
  def change
    create_table :versions do |t|
      t.string  :name, null: false
      t.string  :version
      t.date    :date
      t.text    :description
      t.integer :stars
      t.string  :repo_description
      t.string  :status
      t.string  :repo_url, null: false
      t.string  :changelog_url

      t.timestamps
    end
    add_index :versions, :name
    add_index :versions, :date
    add_index :versions, :stars
  end
end
