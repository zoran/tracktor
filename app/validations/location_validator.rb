class LocationValidator < ActiveModel::EachValidator
  include LocationValidations

  def validate_each(record, attr_name, value)
    begin
      longitude = value.x
      latitude = value.y
    rescue # rescue from nil
      false
    end

    unless is_valid_longitude?(longitude) && is_valid_latitude?(latitude)
      record.errors.add(attr_name, error_message)
    end
  end

private

  # :valid points to this locale
  # en.activerecord.errors.models.location.attributes.lcoation.valid
  def error_message
    options.fetch(:messages, :valid)
  end
end
