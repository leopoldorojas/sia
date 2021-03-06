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

ActiveRecord::Schema.define(version: 20150729180219) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "certificates", force: true do |t|
    t.string   "identifier"
    t.string   "shares_info"
    t.integer  "share_holder_id"
    t.date     "certificate_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "certificates", ["share_holder_id"], name: "index_certificates_on_share_holder_id", using: :btree

  create_table "companies", force: true do |t|
    t.string   "name"
    t.integer  "last_share_issued"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "last_share_issued_before_initial_load"
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
    t.integer  "initial_number_of_shares"
    t.integer  "shares_assigned_after_initial_load"
  end

  add_index "share_holders", ["location_id"], name: "index_share_holders_on_location_id", using: :btree

  create_table "share_issues", force: true do |t|
    t.date     "issue_date"
    t.integer  "initial_share"
    t.integer  "final_share"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "share_type_id"
    t.string   "type"
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
    t.integer  "source_share_holder_id"
    t.string   "type"
    t.integer  "shares_required"
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

  create_table "users", force: true do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.boolean  "approved",               default: false, null: false
    t.integer  "company_id"
    t.string   "role"
  end

  add_index "users", ["company_id"], name: "index_users_on_company_id", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
