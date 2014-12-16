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

ActiveRecord::Schema.define(version: 20141121222032) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "companies", force: true do |t|
    t.string   "name"
    t.integer  "last_share_issued"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "locations", force: true do |t|
    t.string   "name"
    t.string   "type"
    t.integer  "parent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "receipts", force: true do |t|
    t.string   "number"
    t.string   "type"
    t.date     "receipt_date"
    t.text     "description"
    t.integer  "share_operation_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "receipts", ["share_operation_id"], name: "index_receipts_on_share_operation_id", using: :btree

  create_table "share_holders", force: true do |t|
    t.string   "name"
    t.string   "identifier"
    t.string   "contact"
    t.string   "phone"
    t.string   "email"
    t.integer  "location_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "equity"
    t.decimal  "earnings"
    t.decimal  "stock_prepaid"
  end

  add_index "share_holders", ["location_id"], name: "index_share_holders_on_location_id", using: :btree

  create_table "share_issues", force: true do |t|
    t.date     "issue_date"
    t.integer  "initial_share"
    t.integer  "final_share"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "share_type_id"
  end

  add_index "share_issues", ["share_type_id"], name: "index_share_issues_on_share_type_id", using: :btree

  create_table "share_operations", force: true do |t|
    t.date     "operation_date"
    t.integer  "share_holder_id"
    t.decimal  "cash"
    t.decimal  "dividends"
    t.decimal  "adjustment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "share_operations", ["share_holder_id"], name: "index_share_operations_on_share_holder_id", using: :btree

  create_table "share_types", force: true do |t|
    t.string   "identifier"
    t.decimal  "value"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "company_id"
  end

  add_index "share_types", ["company_id"], name: "index_share_types_on_company_id", using: :btree

  create_table "shares", force: true do |t|
    t.integer  "identifier"
    t.integer  "share_operation_id"
    t.integer  "share_issue_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "share_holder_id"
  end

  add_index "shares", ["share_issue_id"], name: "index_shares_on_share_issue_id", using: :btree
  add_index "shares", ["share_operation_id"], name: "index_shares_on_share_operation_id", using: :btree

end
