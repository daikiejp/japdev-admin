# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_10_25_095600) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "articles", force: :cascade do |t|
    t.string "title", null: false
    t.string "source"
    t.string "url", null: false
    t.date "date"
    t.text "tags"
    t.string "image"
    t.text "description"
    t.string "author"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["date"], name: "index_articles_on_date"
    t.index ["source"], name: "index_articles_on_source"
  end

  create_table "devsheet_categories", force: :cascade do |t|
    t.string "name", null: false
    t.string "slug", null: false
    t.string "logo"
    t.text "description"
    t.string "color"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "slug"], name: "index_devsheet_categories_on_name_and_slug", unique: true
  end

  create_table "devsheet_code_block_tabs", force: :cascade do |t|
    t.bigint "devsheet_code_block_id", null: false
    t.string "label", null: false
    t.text "code", null: false
    t.string "language"
    t.string "title"
    t.integer "position", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["devsheet_code_block_id"], name: "index_devsheet_code_block_tabs_on_devsheet_code_block_id"
    t.index ["position"], name: "index_devsheet_code_block_tabs_on_position"
  end

  create_table "devsheet_code_blocks", force: :cascade do |t|
    t.bigint "devsheet_section_id", null: false
    t.string "title"
    t.string "language"
    t.string "filename"
    t.text "code", null: false
    t.text "highlight_lines"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["devsheet_section_id"], name: "index_devsheet_code_blocks_on_devsheet_section_id"
  end

  create_table "devsheet_sections", force: :cascade do |t|
    t.bigint "devsheet_topic_id", null: false
    t.string "title", null: false
    t.string "slug", null: false
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["devsheet_topic_id"], name: "index_devsheet_sections_on_devsheet_topic_id"
  end

  create_table "devsheet_topics", force: :cascade do |t|
    t.bigint "devsheet_category_id", null: false
    t.string "name", null: false
    t.string "slug", null: false
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["devsheet_category_id", "name", "slug"], name: "idx_on_devsheet_category_id_name_slug_c4e3889068", unique: true
    t.index ["devsheet_category_id"], name: "index_devsheet_topics_on_devsheet_category_id"
  end

  create_table "resources", force: :cascade do |t|
    t.string "title", null: false
    t.text "desc"
    t.string "category", null: false
    t.string "url", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category"], name: "index_resources_on_category"
  end

  create_table "versions", force: :cascade do |t|
    t.string "name", null: false
    t.string "version"
    t.date "date"
    t.text "description"
    t.integer "stars"
    t.string "repo_description"
    t.string "status"
    t.string "repo_url", null: false
    t.string "changelog_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["date"], name: "index_versions_on_date"
    t.index ["name"], name: "index_versions_on_name"
    t.index ["stars"], name: "index_versions_on_stars"
  end

  add_foreign_key "devsheet_code_block_tabs", "devsheet_code_blocks"
  add_foreign_key "devsheet_code_blocks", "devsheet_sections"
  add_foreign_key "devsheet_sections", "devsheet_topics"
  add_foreign_key "devsheet_topics", "devsheet_categories"
end
