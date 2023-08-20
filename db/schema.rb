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

ActiveRecord::Schema[7.0].define(version: 2023_08_20_114222) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "actions", force: :cascade do |t|
    t.string "name"
    t.string "action_type", default: "plugin"
    t.string "on"
    t.text "action"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "consumer_id", null: false
    t.index ["consumer_id"], name: "index_actions_on_consumer_id"
  end

  create_table "consumers", id: false, force: :cascade do |t|
    t.string "uuid", null: false
    t.string "nickname"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "num_tabs"
    t.boolean "has_active"
    t.boolean "locked"
    t.datetime "last_ping", precision: nil
    t.index ["uuid"], name: "index_consumers_on_uuid", unique: true
  end

  create_table "urls", force: :cascade do |t|
    t.string "url"
    t.bigint "action_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "consumer_id", null: false
    t.string "url_from"
    t.index ["action_id"], name: "index_urls_on_action_id"
    t.index ["consumer_id"], name: "index_urls_on_consumer_id"
  end

  add_foreign_key "urls", "actions"
  add_foreign_key "urls", "consumers", primary_key: "uuid"
end
