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

ActiveRecord::Schema.define(version: 20160809232809) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "options", force: :cascade do |t|
    t.string   "text"
    t.integer  "question_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["question_id"], name: "index_options_on_question_id", using: :btree
  end

  create_table "questions", force: :cascade do |t|
    t.integer  "question_type"
    t.text     "text"
    t.boolean  "required"
    t.integer  "survey_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["survey_id"], name: "index_questions_on_survey_id", using: :btree
  end

  create_table "responses", force: :cascade do |t|
    t.integer  "submission_id"
    t.integer  "question_id"
    t.integer  "option_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["option_id"], name: "index_responses_on_option_id", using: :btree
    t.index ["question_id"], name: "index_responses_on_question_id", using: :btree
    t.index ["submission_id"], name: "index_responses_on_submission_id", using: :btree
  end

  create_table "submissions", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "survey_id"
  end

  create_table "surveys", force: :cascade do |t|
    t.string   "title"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_foreign_key "options", "questions"
  add_foreign_key "questions", "surveys"
  add_foreign_key "responses", "options"
  add_foreign_key "responses", "questions"
  add_foreign_key "responses", "submissions"
end
