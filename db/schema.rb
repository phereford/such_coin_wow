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

ActiveRecord::Schema.define(version: 20140119174016) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "coins", force: true do |t|
    t.integer  "user_id",                        null: false
    t.string   "name",                           null: false
    t.string   "ticker",                         null: false
    t.boolean  "mined",          default: false
    t.datetime "last_synced_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "coins", ["mined"], name: "index_coins_on_mined", using: :btree
  add_index "coins", ["name"], name: "index_coins_on_name", unique: true, using: :btree
  add_index "coins", ["ticker"], name: "index_coins_on_ticker", unique: true, using: :btree
  add_index "coins", ["user_id"], name: "index_coins_on_user_id", using: :btree

  create_table "delayed_jobs", force: true do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "exchange_rates", force: true do |t|
    t.integer  "coin_id"
    t.string   "market"
    t.string   "market_id"
    t.string   "market_type"
    t.datetime "occurred_at"
    t.float    "rate"
  end

  add_index "exchange_rates", ["coin_id"], name: "index_exchange_rates_on_coin_id", using: :btree

  create_table "transactions", force: true do |t|
    t.integer  "coin_id"
    t.string   "account"
    t.string   "address"
    t.string   "category"
    t.float    "amount"
    t.integer  "confirmations"
    t.string   "block_hash"
    t.string   "block_index"
    t.string   "transaction_id"
    t.datetime "occurred_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "transactions", ["coin_id"], name: "index_transactions_on_coin_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "authentication_token",                null: false
    t.hstore   "total_coins",            default: "", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["total_coins"], name: "user_total_coins", using: :gin

end
