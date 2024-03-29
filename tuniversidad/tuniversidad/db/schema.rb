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

ActiveRecord::Schema.define(version: 20171020223638) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "areas", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "campus", force: :cascade do |t|
    t.string   "title",         default: ""
    t.integer  "university_id"
    t.string   "lat",           default: ""
    t.string   "long",          default: ""
    t.string   "address",       default: ""
    t.integer  "city_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.index ["city_id"], name: "index_campus_on_city_id", using: :btree
    t.index ["university_id"], name: "index_campus_on_university_id", using: :btree
  end

  create_table "carreer_answers", force: :cascade do |t|
    t.integer  "carreer_question_id"
    t.integer  "user_id"
    t.string   "answer",              default: ""
    t.integer  "likes",               default: 0
    t.integer  "dislikes",            default: 0
    t.datetime "date"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.index ["carreer_question_id"], name: "index_carreer_answers_on_carreer_question_id", using: :btree
    t.index ["user_id"], name: "index_carreer_answers_on_user_id", using: :btree
  end

  create_table "carreer_questions", force: :cascade do |t|
    t.integer  "carreer_id"
    t.integer  "user_id"
    t.string   "question",   default: ""
    t.string   "details",    default: ""
    t.integer  "likes",      default: 0
    t.integer  "dislikes",   default: 0
    t.datetime "date"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.index ["carreer_id"], name: "index_carreer_questions_on_carreer_id", using: :btree
    t.index ["user_id"], name: "index_carreer_questions_on_user_id", using: :btree
  end

  create_table "carreers", force: :cascade do |t|
    t.text     "title",         default: ""
    t.integer  "university_id"
    t.integer  "campu_id"
    t.integer  "semesters",     default: 0
    t.integer  "price",         default: 0
    t.string   "schedule",      default: ""
    t.integer  "openings",      default: 0
    t.float    "employability", default: 0.0
    t.integer  "income",        default: 0
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.string   "admission",     default: "PSU"
    t.integer  "last_cut"
    t.text     "description",   default: ""
    t.integer  "area_id"
    t.integer  "visits",        default: 0
    t.boolean  "certification"
    t.index ["area_id"], name: "index_carreers_on_area_id", using: :btree
    t.index ["campu_id"], name: "index_carreers_on_campu_id", using: :btree
    t.index ["university_id"], name: "index_carreers_on_university_id", using: :btree
  end

  create_table "carreers_users", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "carreer_id"
    t.index ["carreer_id"], name: "index_carreers_users_on_carreer_id", using: :btree
    t.index ["user_id", "carreer_id"], name: "index_carreers_users_on_user_id_and_carreer_id", unique: true, using: :btree
  end

  create_table "cities", force: :cascade do |t|
    t.string   "title",      default: ""
    t.integer  "region_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.index ["region_id"], name: "index_cities_on_region_id", using: :btree
  end

  create_table "countries", force: :cascade do |t|
    t.string   "title",      default: ""
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "essays", force: :cascade do |t|
    t.integer  "score"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "subject_id"
    t.string   "title"
    t.datetime "date_full"
    t.index ["subject_id"], name: "index_essays_on_subject_id", using: :btree
    t.index ["user_id"], name: "index_essays_on_user_id", using: :btree
  end

  create_table "institution_types", force: :cascade do |t|
    t.string   "title",      default: ""
    t.integer  "level_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.index ["level_id"], name: "index_institution_types_on_level_id", using: :btree
  end

  create_table "institutions", force: :cascade do |t|
    t.text     "title",               default: ""
    t.integer  "institution_type_id"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.index ["institution_type_id"], name: "index_institutions_on_institution_type_id", using: :btree
  end

  create_table "levels", force: :cascade do |t|
    t.string   "title",      default: ""
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "news", force: :cascade do |t|
    t.text     "body"
    t.text     "title"
    t.text     "lowering"
    t.text     "picture"
    t.string   "extension"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "author"
  end

  create_table "objectives", force: :cascade do |t|
    t.integer  "subject_id"
    t.integer  "score"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["subject_id"], name: "index_objectives_on_subject_id", using: :btree
    t.index ["user_id"], name: "index_objectives_on_user_id", using: :btree
  end

  create_table "recommendations", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "carreer_id"
    t.integer  "area_id"
    t.boolean  "liked",         default: false
    t.boolean  "seen",          default: false
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.boolean  "essay",         default: false
    t.boolean  "computed_area", default: false
    t.index ["area_id"], name: "index_recommendations_on_area_id", using: :btree
    t.index ["carreer_id"], name: "index_recommendations_on_carreer_id", using: :btree
    t.index ["user_id"], name: "index_recommendations_on_user_id", using: :btree
  end

  create_table "regions", force: :cascade do |t|
    t.string   "title",      default: ""
    t.integer  "country_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.index ["country_id"], name: "index_regions_on_country_id", using: :btree
  end

  create_table "subjects", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "universities", force: :cascade do |t|
    t.string   "foundation",         default: ""
    t.string   "website",            default: ""
    t.boolean  "freeness",           default: false
    t.string   "motto",              default: ""
    t.text     "nick",               default: ""
    t.integer  "institution_id"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.text     "initials",           default: ""
    t.integer  "students"
    t.integer  "teachers"
    t.integer  "degrees"
    t.integer  "postgraduates"
    t.integer  "doctorates"
    t.text     "description",        default: ""
    t.string   "cover_picture"
    t.string   "cover_extension"
    t.string   "profile_picture"
    t.string   "profile_extension"
    t.integer  "university_type_id"
    t.integer  "visits",             default: 0
    t.index ["institution_id"], name: "index_universities_on_institution_id", using: :btree
    t.index ["university_type_id"], name: "index_universities_on_university_type_id", using: :btree
  end

  create_table "university_answers", force: :cascade do |t|
    t.integer  "university_question_id"
    t.integer  "user_id"
    t.string   "answer",                 default: ""
    t.integer  "likes",                  default: 0
    t.integer  "dislikes",               default: 0
    t.datetime "date"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["university_question_id"], name: "index_university_answers_on_university_question_id", using: :btree
    t.index ["user_id"], name: "index_university_answers_on_user_id", using: :btree
  end

  create_table "university_questions", force: :cascade do |t|
    t.integer  "university_id"
    t.integer  "user_id"
    t.string   "question",      default: ""
    t.string   "details",       default: ""
    t.integer  "likes",         default: 0
    t.integer  "dislikes",      default: 0
    t.datetime "date"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.index ["university_id"], name: "index_university_questions_on_university_id", using: :btree
    t.index ["user_id"], name: "index_university_questions_on_user_id", using: :btree
  end

  create_table "university_types", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
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
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "auth_token",             default: ""
    t.string   "first_name",             default: ""
    t.string   "rut",                    default: ""
    t.datetime "birth_date"
    t.integer  "city_id"
    t.string   "phone",                  default: ""
    t.integer  "institution_id"
    t.boolean  "admin",                  default: false
    t.boolean  "preuniversity",          default: false
    t.boolean  "notifications",          default: true
    t.integer  "level_id"
    t.string   "last_name"
    t.float    "nem"
    t.string   "picture"
    t.string   "extension"
    t.boolean  "tutorial",               default: false
    t.integer  "ranking"
    t.boolean  "writer",                 default: false
    t.index ["auth_token"], name: "index_users_on_auth_token", unique: true, using: :btree
    t.index ["city_id"], name: "index_users_on_city_id", using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["institution_id"], name: "index_users_on_institution_id", using: :btree
    t.index ["level_id"], name: "index_users_on_level_id", using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "weighings", force: :cascade do |t|
    t.integer  "NEM"
    t.integer  "ranking"
    t.integer  "language"
    t.integer  "math"
    t.integer  "science"
    t.integer  "history"
    t.integer  "carreer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["carreer_id"], name: "index_weighings_on_carreer_id", using: :btree
  end

end
