require "test_helper"

class TestApiConstraint < MiniTest::Test
  def test_matches?
    valid_instance = build(:api_constraint, version: 1)

    valid_request = Struct.new(:headers).new(accept: "application/vnd.spotars.tracktor.v1+json")
    invalid_request = Struct.new(:headers).new(accept: "application/vnd.spotars.tracktor.v0+json")

    assert valid_instance.matches?(valid_request)
    refute valid_instance.matches?(invalid_request)
  end

  def test_version_invalid
    assert_raises ArgumentError do
      build(:api_constraint)
    end

    assert_raises ArgumentError do
      build(:api_constraint, version: nil)
    end

    assert_raises ArgumentError do
      build(:api_constraint, version: "")
    end

    assert_raises ArgumentError do
      build(:api_constraint, version: "not a number")
    end

    assert_raises ArgumentError do
      build(:api_constraint, version: 0)
    end
  end

  def test_too_many_args
    assert_raises NoMethodError do
      build(:api_constraint, version: 1, invalid_attr: "too many args")
    end
  end

  def test_valid_version
    versions = [1,2]

    versions.each do |v|
      api_constraint = build(:api_constraint, version: v)
      assert_equal api_constraint.version, v
    end
  end
end
