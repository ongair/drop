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

ActiveRecord::Schema.define(version: 20150715095257) do

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
  end

  create_table "subscribers", force: :cascade do |t|
    t.string   "source"
    t.string   "external_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "provider"
    t.string   "uid"
  end

end
