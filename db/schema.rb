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

ActiveRecord::Schema[7.0].define(version: 2023_05_17_055234) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "citext"
  enable_extension "plpgsql"

  create_table "actions", force: :cascade do |t|
    t.bigint "location_id"
    t.integer "cost", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "index"
    t.integer "status", default: 0
    t.boolean "necessary", default: false
    t.string "dependencies"
    t.bigint "game_id"
    t.index ["game_id"], name: "index_actions_on_game_id"
    t.index ["location_id"], name: "index_actions_on_location_id"
  end

  create_table "games", force: :cascade do |t|
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "archetype"
    t.datetime "started_at", precision: nil
    t.datetime "ended_at", precision: nil
  end

  create_table "items", force: :cascade do |t|
    t.bigint "game_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.integer "quantity"
    t.index ["game_id"], name: "index_items_on_game_id"
    t.index ["user_id"], name: "index_items_on_user_id"
  end

  create_table "locations", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "index"
    t.bigint "game_id"
    t.index ["game_id"], name: "index_locations_on_game_id"
  end

  create_table "scores", force: :cascade do |t|
    t.bigint "game_id", null: false
    t.bigint "user_id", null: false
    t.string "archetype", null: false
    t.integer "resource", null: false
    t.integer "time", null: false
    t.integer "total", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_scores_on_game_id"
    t.index ["user_id"], name: "index_scores_on_user_id"
  end

  create_table "user_games", force: :cascade do |t|
    t.bigint "game_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status", default: 0
    t.index ["game_id"], name: "index_user_games_on_game_id"
    t.index ["user_id"], name: "index_user_games_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "uuid", null: false
    t.bigint "game_id"
    t.citext "email"
    t.string "name"
    t.index ["email"], name: "index_users_on_email"
    t.index ["game_id"], name: "index_users_on_game_id"
  end

  add_foreign_key "items", "games"
  add_foreign_key "items", "games", column: "user_id"
  add_foreign_key "scores", "games"
  add_foreign_key "scores", "users"
  add_foreign_key "user_games", "games"
  add_foreign_key "user_games", "users"
end
