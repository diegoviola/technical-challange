# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_05_05_060237) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "contracts", force: :cascade do |t|
    t.decimal "value"
    t.bigint "document_datum_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["document_datum_id"], name: "index_contracts_on_document_datum_id"
  end

  create_table "customers", force: :cascade do |t|
    t.string "name"
    t.bigint "document_datum_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["document_datum_id"], name: "index_customers_on_document_datum_id"
  end

  create_table "document_data", force: :cascade do |t|
    t.bigint "document_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["document_id"], name: "index_document_data_on_document_id"
  end

  create_table "documents", force: :cascade do |t|
    t.string "uuid"
    t.string "pdf_url"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "remote", default: false
  end

  add_foreign_key "contracts", "document_data"
  add_foreign_key "customers", "document_data"
  add_foreign_key "document_data", "documents"
end
