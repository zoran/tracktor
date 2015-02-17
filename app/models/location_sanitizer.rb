module LocationSanitizer
  include LocationValidations

  # We accept 0 - 360.4999999999999 . A negative value is not
  # allowed - see LocationValidations. Values are rounded:
  # 360.4999999999999 would be accepted f.i. but it will be
  # rounded to 360. Compass is inaccurate by nature and this
  # approach which could lead to a inaccuracy < 0.5 degree
  # is a good compromise. Invalid values will result in nil
  # but will not lead to 4xx since the presence of bearing
  # is not mandatory.
  def sanitize_bearing(bearing)

    # Normally a bearing of exactly 0 means that the device
    # returned an invalid value.
    return nil if bearing && bearing == 0

    rounded = Float(bearing).round rescue nil
    is_valid_bearing?(rounded) ? rounded : nil
  end
end
