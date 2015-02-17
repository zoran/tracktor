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

ActiveRecord::Schema.define(version: 20150208233421) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "postgis"

  create_table "locations", force: true do |t|
    t.spatial  "location",               limit: {:srid=>4326, :type=>"point", :geographic=>true}, null: false
    t.integer  "user_id",                                                                         null: false
    t.datetime "recorded_at",                                                                     null: false
    t.integer  "bearing"
    t.string   "tracktor_api_ver",                                                                null: false
    t.string   "tracktor_api_subdomain"
    t.datetime "created_at",                                                                      null: false
  end

  add_index "locations", ["location"], :name => "index_locations_on_location", :spatial => true
  add_index "locations", ["user_id"], :name => "index_locations_on_user_id"

end
