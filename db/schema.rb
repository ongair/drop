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

ActiveRecord::Schema.define(version: 20150812142719) do

  create_table "admins", force: :cascade do |t|
    t.string   "name"
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
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true

  create_table "article_logs", force: :cascade do |t|
    t.integer  "article_id"
    t.integer  "subscriber_id"
    t.string   "type"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "article_logs", ["article_id"], name: "index_article_logs_on_article_id"
  add_index "article_logs", ["subscriber_id"], name: "index_article_logs_on_subscriber_id"

  create_table "articles", force: :cascade do |t|
    t.string   "source"
    t.string   "title"
    t.text     "summary"
    t.string   "url"
    t.string   "article_type"
    t.text     "metadata"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "category_id"
    t.string   "external_id"
    t.string   "image_url"
    t.text     "body"
    t.boolean  "archived",     default: false
  end

  add_index "articles", ["category_id"], name: "index_articles_on_category_id"

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.string   "source"
    t.text     "keywords"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "metadata"
    t.text     "description"
    t.integer  "parent_id"
    t.boolean  "enabled",     default: true
    t.string   "image_uid"
    t.string   "image_name"
  end

  add_index "categories", ["parent_id"], name: "index_categories_on_parent_id"

  create_table "sources", force: :cascade do |t|
    t.string   "name"
    t.boolean  "active",     default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "juicer_id"
  end

  create_table "subscriber_categories", force: :cascade do |t|
    t.integer  "subscriber_id"
    t.integer  "category_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "subscriber_categories", ["category_id"], name: "index_subscriber_categories_on_category_id"
  add_index "subscriber_categories", ["subscriber_id"], name: "index_subscriber_categories_on_subscriber_id"

  create_table "subscribers", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "provider"
    t.string   "uid"
    t.integer  "sign_in_count"
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
  end

end
