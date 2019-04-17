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

ActiveRecord::Schema.define(version: 2019_04_17_163059) do

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "size"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "api_id"
    t.string "api_source"
  end

  create_table "company_industries", id: false, force: :cascade do |t|
    t.integer "company_id", null: false
    t.integer "industry_id", null: false
    t.index ["company_id", "industry_id"], name: "index_company_industries_on_company_id_and_industry_id"
    t.index ["industry_id", "company_id"], name: "index_company_industries_on_industry_id_and_company_id"
  end

  create_table "company_locations", id: false, force: :cascade do |t|
    t.integer "company_id", null: false
    t.integer "location_id", null: false
    t.index ["company_id", "location_id"], name: "index_company_locations_on_company_id_and_location_id"
    t.index ["location_id", "company_id"], name: "index_company_locations_on_location_id_and_company_id"
  end

  create_table "industries", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "job_categories", id: false, force: :cascade do |t|
    t.integer "job_id", null: false
    t.integer "category_id", null: false
    t.index ["category_id", "job_id"], name: "index_job_categories_on_category_id_and_job_id"
    t.index ["job_id", "category_id"], name: "index_job_categories_on_job_id_and_category_id"
  end

  create_table "job_locations", id: false, force: :cascade do |t|
    t.integer "job_id", null: false
    t.integer "location_id", null: false
    t.index ["job_id", "location_id"], name: "index_job_locations_on_job_id_and_location_id"
    t.index ["location_id", "job_id"], name: "index_job_locations_on_location_id_and_job_id"
  end

  create_table "jobs", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.integer "level"
    t.boolean "published", default: false
    t.datetime "published_at"
    t.datetime "unpublished_at"
    t.integer "company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "api_id"
    t.string "api_source"
  end

  create_table "locations", force: :cascade do |t|
    t.string "city"
    t.string "state"
    t.string "country"
    t.boolean "remote"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
  end

end
