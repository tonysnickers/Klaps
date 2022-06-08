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

ActiveRecord::Schema[7.0].define(version: 2022_06_08_102856) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "dashboards", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "movie_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["movie_id"], name: "index_dashboards_on_movie_id"
    t.index ["user_id"], name: "index_dashboards_on_user_id"
  end

  create_table "friends", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "users_friend_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_friends_on_user_id"
    t.index ["users_friend_id"], name: "index_friends_on_users_friend_id"
  end

  create_table "group_users", force: :cascade do |t|
    t.bigint "group_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "movie_order", default: [], array: true
    t.index ["group_id"], name: "index_group_users_on_group_id"
    t.index ["user_id"], name: "index_group_users_on_user_id"
  end

  create_table "groups", force: :cascade do |t|
    t.string "name"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "archive", default: false
    t.index ["user_id"], name: "index_groups_on_user_id"
  end

  create_table "movies", force: :cascade do |t|
    t.string "name"
    t.integer "duration"
    t.integer "rating"
    t.integer "year"
    t.string "country"
    t.string "keyword"
    t.string "restriction"
    t.string "poster"
    t.string "platform"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "synopsis"
    t.string "genre"
    t.string "actor"
  end

  create_table "ordered_choices", force: :cascade do |t|
    t.integer "point"
    t.bigint "movie_id", null: false
    t.bigint "group_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_ordered_choices_on_group_id"
    t.index ["movie_id"], name: "index_ordered_choices_on_movie_id"
  end

  create_table "quizz_choices", force: :cascade do |t|
    t.string "genre"
    t.string "actor"
    t.string "keyword"
    t.integer "duration", default: 180
    t.bigint "group_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "step", default: "initial"
    t.integer "start_year", default: 1960
    t.integer "end_year", default: 2022
    t.boolean "sent", default: false
    t.index ["group_id"], name: "index_quizz_choices_on_group_id"
    t.index ["user_id"], name: "index_quizz_choices_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username", default: "", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "wishes", force: :cascade do |t|
    t.bigint "movie_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["movie_id"], name: "index_wishes_on_movie_id"
    t.index ["user_id"], name: "index_wishes_on_user_id"
  end

  add_foreign_key "dashboards", "movies"
  add_foreign_key "dashboards", "users"
  add_foreign_key "friends", "users"
  add_foreign_key "friends", "users", column: "users_friend_id"
  add_foreign_key "group_users", "groups"
  add_foreign_key "group_users", "users"
  add_foreign_key "groups", "users"
  add_foreign_key "ordered_choices", "groups"
  add_foreign_key "ordered_choices", "movies"
  add_foreign_key "quizz_choices", "groups"
  add_foreign_key "quizz_choices", "users"
  add_foreign_key "wishes", "movies"
  add_foreign_key "wishes", "users"
end
