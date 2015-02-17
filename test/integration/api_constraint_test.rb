require "test_helper"

describe ApiConstraint do
  include Rack::Test::Methods

  let(:valid_version){ 1 }
  let(:invalid_version){ 0 }

  # OPTIONS is used to check media type and API version as well.
  describe "OPTIONS call with API version" do
    it "valid version returns code 200" do
      request_options(valid_version)
      last_response.status.must_equal 200
    end

    it "returns code 200 from tracktor-stag subdomain" do
      header "Accept", "application/vnd.spotars.tracktor.v#{valid_version}+json"
      options "https://tracktor-stag.spotars.lan:3000/locations"
      last_response.status.must_equal 200
    end

    it "invalid version returns code 404" do
      request_options(invalid_version)
      last_response.status.must_equal 404
    end

    it "valid media type" do
      request_options(valid_version)
      last_request.env.fetch("HTTP_ACCEPT").must_equal "application/vnd.spotars.tracktor.v1+json"
    end
  end

  describe "Initialize API with valid version" do
    it "validates" do
      build(:api_constraint, version: valid_version).version.must_equal valid_version
    end
  end

  def request_options(v)
    header "Accept", "application/vnd.spotars.tracktor.v#{v}+json"
    options "https://tracktor.spotars.lan:3000/locations"
  end
end
