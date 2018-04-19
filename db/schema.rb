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

ActiveRecord::Schema.define(version: 20180419084151) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "answer_votes", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "answer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["answer_id"], name: "index_answer_votes_on_answer_id"
    t.index ["user_id"], name: "index_answer_votes_on_user_id"
  end

  create_table "answers", force: :cascade do |t|
    t.bigint "question_id"
    t.text "content"
    t.integer "answer_votes_count", default: 0
    t.bigint "user_id"
    t.bigint "stream_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["question_id"], name: "index_answers_on_question_id"
    t.index ["stream_id"], name: "index_answers_on_stream_id"
    t.index ["user_id"], name: "index_answers_on_user_id"
  end

  create_table "channels", force: :cascade do |t|
    t.string "name"
    t.bigint "streamer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.index ["streamer_id"], name: "index_channels_on_streamer_id"
  end

  create_table "chat_messages", force: :cascade do |t|
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "stream_id"
    t.bigint "user_id"
    t.index ["stream_id"], name: "index_chat_messages_on_stream_id"
    t.index ["user_id"], name: "index_chat_messages_on_user_id"
  end

  create_table "follows", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "follower_id"
    t.bigint "channel_id"
    t.index ["channel_id"], name: "index_follows_on_channel_id"
    t.index ["follower_id"], name: "index_follows_on_follower_id"
  end

  create_table "likes", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "stream_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["stream_id"], name: "index_likes_on_stream_id"
    t.index ["user_id"], name: "index_likes_on_user_id"
  end

  create_table "question_votes", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "question_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["question_id"], name: "index_question_votes_on_question_id"
    t.index ["user_id"], name: "index_question_votes_on_user_id"
  end

  create_table "questions", force: :cascade do |t|
    t.text "content"
    t.bigint "user_id"
    t.bigint "stream_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "question_votes_count", default: 0
    t.index ["stream_id"], name: "index_questions_on_stream_id"
    t.index ["user_id"], name: "index_questions_on_user_id"
  end

  create_table "streams", force: :cascade do |t|
    t.string "token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "session_id"
    t.bigint "channel_id"
    t.integer "likes_count", default: 0
    t.index ["channel_id"], name: "index_streams_on_channel_id"
  end

  create_table "stripe_products", force: :cascade do |t|
    t.bigint "user_id"
    t.string "name"
    t.integer "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_stripe_products_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "refresh_token"
    t.string "first_name"
    t.string "last_name"
    t.string "pseudo"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
