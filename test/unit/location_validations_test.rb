require "test_helper"

# == Notice
# This class is not DRY. Much duplication for better reading.
class TestLocationValidations < MiniTest::Test
  include LocationValidations

  # Valid longitude -179.99999999..180
  def test_is_valid_longitude?
    assert is_valid_longitude?(180)
    assert is_valid_longitude?(180.0)
    assert is_valid_longitude?("180")
    assert is_valid_longitude?(0)
    assert is_valid_longitude?(-0)
    assert is_valid_longitude?(-179.99999999)

    refute is_valid_longitude?(-179.999999999)
    refute is_valid_longitude?(180.00000001)

    check_arg_error("is_valid_longitude?")
    check_weird_values("is_valid_longitude?")
  end

  # Valid latitude: -89.99999999..90
  def test_is_valid_latitude?
    assert is_valid_latitude?(90)
    assert is_valid_latitude?(90.0)
    assert is_valid_latitude?("90")
    assert is_valid_latitude?(0)
    assert is_valid_latitude?(-0)
    assert is_valid_latitude?(-89.99999999)

    refute is_valid_latitude?(-89.999999999)
    refute is_valid_latitude?(90.000000001)

    check_arg_error("is_valid_latitude?")
    check_weird_values("is_valid_latitude?")
  end

  def test_is_valid_utc_time?
    assert is_valid_utc_time?("Thu, 05 Feb 2015 16:47:10 UTC 00:00")
    assert is_valid_utc_time?("Thu, 05 Feb 2015 16:47:10 UTC 01:00") # 01:00 is ignored due to "UTC"
    refute is_valid_utc_time?("Thu, 05 Feb 2015 16:47:10 01:00")
    refute is_valid_utc_time?("Thu, 05 Feb 2015 16:47:10 00:00")
    refute is_valid_utc_time?("Thu, 05 Feb 2015")
    refute is_valid_utc_time?("Thu, 05 Feb 2015 UTC")

    check_weird_values("is_valid_utc_time?")
    check_arg_error("is_valid_utc_time?")
  end

  # Bearing: positive 0 and 360 is allowed
  def test_is_valid_bearing?
    assert is_valid_bearing?(0)
    assert is_valid_bearing?(360)
    assert is_valid_bearing?("0")
    refute is_valid_bearing?(-360)
    refute is_valid_bearing?(360.0)
    refute is_valid_bearing?(361)
    refute is_valid_bearing?(1.1)
    refute is_valid_bearing?("1.1")

    check_arg_error("is_valid_bearing?")
    check_weird_values("is_valid_bearing?")
  end

  def check_weird_values(method)
    weird_values = %w(nil ^ ° ! § $ % & / \( \) () { } {} [ ] [] = ? ß ` ´ * + - ~ # , ; . : - _ < > <> | @ € ' " \n \t a_string \ )

    weird_values.each do |w|
      refute send(method, w)
    end
  end

  def check_arg_error(method)
    assert_raises ArgumentError do
      send(method)
    end
  end
end
