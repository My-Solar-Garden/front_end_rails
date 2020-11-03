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

ActiveRecord::Schema.define(version: 2020_10_30_204952) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "garden_healths", force: :cascade do |t|
    t.bigint "sensor_id"
    t.integer "reading_type"
    t.float "reading"
    t.datetime "time_of_reading"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["sensor_id"], name: "index_garden_healths_on_sensor_id"
  end

  create_table "garden_plants", force: :cascade do |t|
    t.bigint "garden_id"
    t.bigint "plant_id"
    t.datetime "planted_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["garden_id"], name: "index_garden_plants_on_garden_id"
    t.index ["plant_id"], name: "index_garden_plants_on_plant_id"
  end

  create_table "gardens", force: :cascade do |t|
    t.float "latitude"
    t.float "longitude"
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "private"
  end

  create_table "plants", force: :cascade do |t|
    t.text "image"
    t.string "name"
    t.string "species"
    t.text "description"
    t.text "light_requirements"
    t.text "water_requirements"
    t.text "when_to_plant"
    t.text "harvest_time"
    t.text "common_pests"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sensors", force: :cascade do |t|
    t.bigint "garden_id"
    t.integer "sensor_type"
    t.integer "min_threshold"
    t.integer "max_threshold"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["garden_id"], name: "index_sensors_on_garden_id"
  end

  create_table "user_gardens", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "garden_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["garden_id"], name: "index_user_gardens_on_garden_id"
    t.index ["user_id"], name: "index_user_gardens_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "provider"
    t.string "token"
    t.string "refresh_token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "uid"
    t.index ["uid"], name: "index_users_on_uid"
  end

  add_foreign_key "garden_healths", "sensors"
  add_foreign_key "garden_plants", "gardens"
  add_foreign_key "garden_plants", "plants"
  add_foreign_key "sensors", "gardens"
  add_foreign_key "user_gardens", "gardens"
  add_foreign_key "user_gardens", "users"
end
