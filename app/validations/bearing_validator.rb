class BearingValidator < ActiveModel::EachValidator
  include LocationValidations

  def validate_each(record, attr_name, value)
    before_type_cast = :"#{attr_name}_before_type_cast"
    raw_value = record.send(before_type_cast)

    unless is_valid_bearing?(raw_value)

      # :nocov: we shouldn't see an error since bearing is sanitized
      # in the model before saved and thus always valid. An invalid
      # value will be saved as nil which is allowed for this attribute.
      record.errors.add(attr_name, error_message)
      # :nocov:
    end
  end

private

  # :valid points to this locale
  # en.activerecord.errors.models.location.attributes.bearing.valid
  def error_message
    # :nocov:
    options.fetch(:messages, :valid)
    # :nocov:
  end

end
