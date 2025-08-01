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

ActiveRecord::Schema[7.1].define(version: 2024_03_19_220509) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.boolean "allow_password_change", default: false
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "email"
    t.json "tokens"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["confirmation_token"], name: "index_admins_on_confirmation_token", unique: true
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_admins_on_uid_and_provider", unique: true
  end

  create_table "api_v1_activities", force: :cascade do |t|
    t.string "name"
    t.bigint "tour_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tour_id"], name: "index_api_v1_activities_on_tour_id"
  end

  create_table "api_v1_bookings", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "tour_id", null: false
    t.string "booking_status", default: "pending", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tour_id"], name: "index_api_v1_bookings_on_tour_id"
    t.index ["user_id"], name: "index_api_v1_bookings_on_user_id"
  end

  create_table "api_v1_cancellations", force: :cascade do |t|
    t.bigint "booking_id", null: false
    t.text "reason"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["booking_id"], name: "index_api_v1_cancellations_on_booking_id"
  end

  create_table "api_v1_categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "api_v1_destinations", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.bigint "tour_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tour_id"], name: "index_api_v1_destinations_on_tour_id"
  end

  create_table "api_v1_prices", force: :cascade do |t|
    t.float "amount"
    t.string "currency"
    t.bigint "tour_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tour_id"], name: "index_api_v1_prices_on_tour_id"
  end

  create_table "api_v1_reviews", force: :cascade do |t|
    t.bigint "tour_id", null: false
    t.bigint "user_id", null: false
    t.integer "rating", null: false
    t.text "review_text", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tour_id"], name: "index_api_v1_reviews_on_tour_id"
    t.index ["user_id"], name: "index_api_v1_reviews_on_user_id"
  end

  create_table "api_v1_tour_dates", force: :cascade do |t|
    t.date "start_date"
    t.date "end_date"
    t.bigint "tour_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tour_id"], name: "index_api_v1_tour_dates_on_tour_id"
  end

  create_table "api_v1_tours", force: :cascade do |t|
    t.string "name", null: false
    t.text "description", null: false
    t.integer "duration", null: false
    t.string "image"
    t.bigint "category_id", null: false
    t.bigint "admin_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["admin_id"], name: "index_api_v1_tours_on_admin_id"
    t.index ["category_id"], name: "index_api_v1_tours_on_category_id"
    t.index ["name"], name: "index_api_v1_tours_on_name", unique: true
  end

  create_table "profiles", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "phone_number"
    t.string "passport"
    t.string "profile_picture"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.boolean "allow_password_change", default: false
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "email"
    t.json "tokens"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true
  end

  add_foreign_key "api_v1_activities", "api_v1_tours", column: "tour_id"
  add_foreign_key "api_v1_bookings", "api_v1_tours", column: "tour_id"
  add_foreign_key "api_v1_bookings", "users"
  add_foreign_key "api_v1_cancellations", "api_v1_bookings", column: "booking_id"
  add_foreign_key "api_v1_destinations", "api_v1_tours", column: "tour_id"
  add_foreign_key "api_v1_prices", "api_v1_tours", column: "tour_id"
  add_foreign_key "api_v1_reviews", "api_v1_tours", column: "tour_id"
  add_foreign_key "api_v1_reviews", "users"
  add_foreign_key "api_v1_tour_dates", "api_v1_tours", column: "tour_id"
  add_foreign_key "api_v1_tours", "admins"
  add_foreign_key "api_v1_tours", "api_v1_categories", column: "category_id"
  add_foreign_key "profiles", "users"
end
