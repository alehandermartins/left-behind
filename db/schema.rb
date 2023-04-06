# frozen_string_literal: true

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

ActiveRecord::Schema[7.0].define(version: 20_230_406_094_320) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'game_actions', force: :cascade do |t|
    t.bigint 'location_id'
    t.integer 'cost', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.integer 'index'
    t.integer 'status', default: 0
    t.index ['location_id'], name: 'index_game_actions_on_location_id'
  end

  create_table 'games', force: :cascade do |t|
    t.integer 'status', default: 0
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'archetype'
  end

  create_table 'items', force: :cascade do |t|
    t.bigint 'game_id', null: false
    t.bigint 'user_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'name'
    t.integer 'quantity'
    t.index ['game_id'], name: 'index_items_on_game_id'
    t.index ['user_id'], name: 'index_items_on_user_id'
  end

  create_table 'locations', force: :cascade do |t|
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.integer 'index'
    t.bigint 'game_id'
    t.index ['game_id'], name: 'index_locations_on_game_id'
  end

  create_table 'user_games', force: :cascade do |t|
    t.bigint 'game_id', null: false
    t.bigint 'user_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['game_id'], name: 'index_user_games_on_game_id'
    t.index ['user_id'], name: 'index_user_games_on_user_id'
  end

  create_table 'users', force: :cascade do |t|
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'uuid', default: 'c51abe77-618e-4bc2-9092-13685e49961e'
  end

  add_foreign_key 'items', 'games'
  add_foreign_key 'items', 'games', column: 'user_id'
  add_foreign_key 'user_games', 'games'
  add_foreign_key 'user_games', 'users'
end
