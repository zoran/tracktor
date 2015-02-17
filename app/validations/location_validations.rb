module LocationValidations

  # Valid longitude -179.99999999..180
  def is_valid_longitude?(longitude)
    /^(-?(?:1[0-7]|[1-9])?\d(?:\.\d{1,8})?|180(?:\.0{1,8})?)$/ === longitude.to_s
  end

  # Valid latitude: -89.99999999..90
  def is_valid_latitude?(latitude)
    /^(-?[1-8]?\d(?:\.\d{1,8})?|90(?:\.0{1,8})?)$/ === latitude.to_s
  end

  # valid format:  "Thu, 29 Jan 2015 15:49:00 UTC +00:00"
  # Always use "Time.zone.now" NOT "Time.now" for current UTC time
  def is_valid_utc_time?(utc_time)
    begin
      Time.parse(utc_time).strftime("%z") == "+0000" &&
          Time.parse(utc_time).strftime("%Z") == "UTC"
    rescue
      false
    end
  end

  def is_valid_bearing?(bearing)
    /^(\d)+$/ === bearing.to_s && bearing.to_i >= 0 && bearing.to_i <= 360
  end
end
