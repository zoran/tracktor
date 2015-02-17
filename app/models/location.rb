# == Description
# This class is all about GIS.
# Learn more about rgeo / postigs:
# * activerecord-postgis-adapter[http://dazuma.github.com/activerecord-postgis-adapter/rdoc/]
# * Spatial Programming With RGeo[https://github.com/dazuma/rgeo/blob/master/Spatial_Programming_With_RGeo.rdoc]
class Location < ActiveRecord::Base
  include LocationSanitizer

  # Set curved factory as default for this model (WGS84 / SRID 4326)
  self.rgeo_factory_generator = RGeo::Geos.factory_generator

  # Use a geographic implementation for the :pos column.
  set_rgeo_factory_for_column(:pos,
      RGeo::Geographic.spherical_factory(
          srid: 4326,
          has_z_coordinate: false,
          has_m_coordinate: false,
          geographic: true))

  # === Validations
  #
  # Our locations controller allows us to immediateldy reject bad post calls for
  # mandatory attributes without bothering ActiveRecord or the Database. Same
  # validations are used here for the model.

  # +location+ consists of longitude and latitude where z and z are optional.
  # * z represents altitude, a distance above or below the surface of the earth.
  # * m represents temperature, population density, or some other function of
  # location. However, we don't use z and m since most of the GIS systems out
  # there are not able to handle them. We use the extra attribute +altitude+
  # instead of z.

  validates :location,
      location: { valid: true },
      presence: true,
      allow_nil: false

  validates :bearing,
      bearing: { valid: true },
      allow_nil: true

  validates :tracktor_api_ver,
      presence: true,
      allow_nil: false

  validates :user_id,
      presence: true,
      allow_nil: false,
      numericality: { greater_than: 0 }

  # === Sanitize
  #
  # some attributes like +bearing+ must be sanitized for which we utilize
  # '_before_type_cast'. That's important because in the case of +bearing+ which
  # is an integer, it will be type casted. This means, saving a String or
  # FalseClass as +bearing+ would end in a 0 (number) because "a_string".to_i == 0 .

  def bearing=(val)
    self[:bearing] = sanitize_bearing(val)
  end
end
