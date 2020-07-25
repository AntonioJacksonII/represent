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

ActiveRecord::Schema.define(version: 20200724001427) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bills", force: :cascade do |t|
    t.string "bill_id"
    t.text "summary_short"
    t.string "congress_url"
    t.text "short_title"
    t.string "primary_subject"
    t.integer "offset"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "passage_roll_call"
  end

  create_table "house_favorites", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "house_member_id"
    t.float "comparison_score"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["house_member_id"], name: "index_house_favorites_on_house_member_id"
    t.index ["user_id"], name: "index_house_favorites_on_user_id"
  end

  create_table "house_members", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "dob"
    t.string "gender"
    t.string "party"
    t.string "leadership_role"
    t.string "facebook_account"
    t.string "twitter_account"
    t.integer "govtrack_id"
    t.string "url"
    t.string "contact_form"
    t.string "cook_pvi"
    t.float "dw_nominate"
    t.integer "total_votes"
    t.integer "missed_votes"
    t.datetime "last_updated"
    t.string "office"
    t.string "phone"
    t.string "state"
    t.integer "district"
    t.float "missed_votes_percentage"
    t.float "votes_with_percentage"
    t.string "congress_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "votes_without_party_percentage"
    t.boolean "at_large"
  end

  create_table "senator_favorites", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "senator_id"
    t.float "comparison_score"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["senator_id"], name: "index_senator_favorites_on_senator_id"
    t.index ["user_id"], name: "index_senator_favorites_on_user_id"
  end

  create_table "senators", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "dob"
    t.string "gender"
    t.string "party"
    t.string "leadership_role"
    t.string "facebook_account"
    t.string "twitter_account"
    t.integer "govtrack_id"
    t.string "url"
    t.string "contact_form"
    t.float "dw_nominate"
    t.integer "next_election"
    t.integer "total_votes"
    t.integer "missed_votes"
    t.datetime "last_updated"
    t.string "office"
    t.string "phone"
    t.string "state"
    t.float "missed_votes_percentage"
    t.float "votes_with_percentage"
    t.string "congress_id"
    t.integer "senate_class"
    t.string "state_rank"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "votes_without_party_percentage"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "house_favorites", "house_members"
  add_foreign_key "house_favorites", "users"
  add_foreign_key "senator_favorites", "senators"
  add_foreign_key "senator_favorites", "users"
end
