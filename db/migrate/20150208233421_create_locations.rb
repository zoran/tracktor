# Z represents altitude, a distance above or below the surface of the earth
# M represents temperature, population density, or some other function of location
#
# srid should be 3857 because 3785 is deprecated.
# but not if geographic: true - in this case srid must be 4326
class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.point :location,
          srid: 4326,
          geographic: true,
          has_z: false,
          has_m: false,
          null: false

      t.integer :user_id, null: false
      t.datetime :recorded_at, null: false
      t.integer :bearing, null: true
      t.string :tracktor_api_ver, null: false
      t.string :tracktor_api_subdomain, null: true
      t.datetime :created_at, null: false
    end

    add_index :locations, :location, spatial: true
    add_index :locations, :user_id
  end
end
