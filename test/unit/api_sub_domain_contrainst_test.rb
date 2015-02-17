require "test_helper"

class TestApiSubDomainConstraint < MiniTest::Test
  def test_matches?
    valid_instance = build(:api_sub_domain_constraint)
    valid_request = Struct.new(:subdomain).new("tracktor")
    invalid_request = Struct.new(:subdomain).new("invalid")

    assert valid_instance.matches?(valid_request)
    refute valid_instance.matches?(invalid_request)
  end
end
