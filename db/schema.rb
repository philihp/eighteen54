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

ActiveRecord::Schema.define(version: 20160907085236) do

  create_table "bids", force: :cascade do |t|
    t.integer  "player_id"
    t.integer  "company_id"
    t.integer  "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_bids_on_company_id"
    t.index ["player_id"], name: "index_bids_on_player_id"
  end

  create_table "companies", force: :cascade do |t|
    t.integer  "instance_id"
    t.string   "type"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.boolean  "tapped"
    t.integer  "cost"
    t.integer  "director_id"
    t.index ["director_id"], name: "index_companies_on_director_id"
    t.index ["instance_id"], name: "index_companies_on_instance_id"
  end

  create_table "instances", force: :cascade do |t|
    t.integer  "round"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "phase"
    t.integer  "bank"
    t.string   "name"
    t.integer  "active_player_id"
    t.integer  "passes"
    t.integer  "priority_id"
    t.integer  "active_company_id"
    t.index ["active_company_id"], name: "index_instances_on_active_company_id"
    t.index ["priority_id"], name: "index_instances_on_priority_id"
  end

  create_table "players", force: :cascade do |t|
    t.string   "name"
    t.integer  "instance_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "wallet"
    t.integer  "turn_order"
    t.index ["instance_id"], name: "index_players_on_instance_id"
  end

end
