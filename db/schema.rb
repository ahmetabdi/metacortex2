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

ActiveRecord::Schema.define(version: 20150915201823) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "links", force: :cascade do |t|
    t.text     "link"
    t.string   "site"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "movie_id",   null: false
  end

  add_index "links", ["movie_id"], name: "index_links_on_movie_id", using: :btree

  create_table "movies", force: :cascade do |t|
    t.integer  "tmdb_id"
    t.string   "title"
    t.string   "backdrop_path"
    t.text     "overview"
    t.string   "release_date"
    t.string   "poster_path"
    t.string   "imdb_id"
    t.integer  "runtime"
    t.integer  "revenue"
    t.string   "status"
    t.text     "tagline"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "state",         default: "generic"
    t.string   "slug"
  end

  add_index "movies", ["slug"], name: "index_movies_on_slug", unique: true, using: :btree

  add_foreign_key "links", "movies"
end
