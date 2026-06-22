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

ActiveRecord::Schema[8.1].define(version: 2026_06_22_085545) do
  create_table "eco_cutes", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "max_current"
    t.integer "tank_capacity"
    t.datetime "updated_at", null: false
  end

  create_table "gas_water_heaters", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "gas_consumption"
    t.integer "gas_type", null: false
    t.datetime "updated_at", null: false
  end

  create_table "oil_water_heaters", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.decimal "fuel_consumption", precision: 4, scale: 1
    t.integer "fuel_type", null: false
    t.datetime "updated_at", null: false
  end

  create_table "products", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "heater_id", null: false
    t.string "heater_type", null: false
    t.string "name", null: false
    t.date "released_on"
    t.datetime "updated_at", null: false
    t.index ["heater_type", "heater_id"], name: "index_products_on_heater"
  end
end
