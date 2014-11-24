# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20141124231503) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "game_answers", force: true do |t|
    t.integer  "game_id",    null: false
    t.string   "answer",     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "regex"
  end

  add_index "game_answers", ["game_id", "answer"], name: "index_game_answers_on_game_id_and_answer", unique: true, using: :btree
  add_index "game_answers", ["game_id"], name: "index_game_answers_on_game_id", using: :btree

  create_table "games", force: true do |t|
    t.string   "title",                                      null: false
    t.string   "subtitle"
    t.string   "source",                                     null: false
    t.integer  "time_limit",                                 null: false
    t.integer  "author_id",                                  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "rounds_count",                   default: 0
    t.integer  "answers_count",                  default: 0
    t.integer  "completed_rounds_count",         default: 0
    t.integer  "completed_answer_matches_count", default: 0
  end

  add_index "games", ["author_id"], name: "index_games_on_author_id", using: :btree
  add_index "games", ["title"], name: "index_games_on_title", unique: true, using: :btree

  create_table "notifications", force: true do |t|
    t.integer  "user_id"
    t.integer  "notifiable_id"
    t.string   "notifiable_type"
    t.integer  "event_id"
    t.boolean  "is_read",         default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pg_search_documents", force: true do |t|
    t.text     "content"
    t.integer  "searchable_id"
    t.string   "searchable_type"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "round_answer_matches", force: true do |t|
    t.integer  "round_id",   null: false
    t.integer  "answer_id",  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "round_answer_matches", ["answer_id"], name: "index_round_answer_matches_on_answer_id", using: :btree
  add_index "round_answer_matches", ["round_id", "answer_id"], name: "index_round_answer_matches_on_round_id_and_answer_id", unique: true, using: :btree
  add_index "round_answer_matches", ["round_id"], name: "index_round_answer_matches_on_round_id", using: :btree

  create_table "rounds", force: true do |t|
    t.integer  "game_id",                      null: false
    t.integer  "player_id"
    t.boolean  "is_completed", default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "start_time"
  end

  add_index "rounds", ["game_id"], name: "index_rounds_on_game_id", using: :btree
  add_index "rounds", ["player_id"], name: "index_rounds_on_player_id", using: :btree

  create_table "sessions", force: true do |t|
    t.integer  "user_id",       null: false
    t.string   "session_token", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_token"], name: "index_sessions_on_session_token", unique: true, using: :btree
  add_index "sessions", ["user_id"], name: "index_sessions_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "username",                                         null: false
    t.string   "email",                                            null: false
    t.string   "name"
    t.string   "password_digest",                                  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "rounds_count",                         default: 0
    t.integer  "completed_rounds_count",               default: 0
    t.integer  "completed_answer_matches_count",       default: 0
    t.integer  "created_games_count",                  default: 0
    t.integer  "created_games_completed_rounds_count", default: 0
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

end
