require "test_helper"

describe Tracktor::V1::LocationsController do
  include Rack::Test::Methods

  let(:valid_version){ 1 }
  let(:invalid_version){ 0 }

  describe "Post with valid data" do
    it "responds with status code 200" do
      valid_body = { "location":
          { "longitude":"11",
            "latitude":"11",
            "bearing":"360",
            "recorded_at":"2015-01-29T15:49Z"
          },
          "user_id":"123"
      }

      header "Accept", "application/vnd.spotars.tracktor.v#{valid_version}+json"
      header "Content-Type", "application/json"
      post "https://tracktor.spotars.lan:3000/locations", valid_body.to_json

      # This is a workaround to satisfy the cordova plugin which
      # epexts 200. Code should be 201 rightly because we created a record.
      last_response.status.must_equal 200
    end
  end

  describe "Post with invalid data" do
    it "responds with status code 415" do
      header "Accept", "application/vnd.spotars.tracktor.v#{invalid_version}+json"
      header "Content-Type", "application/json"
      post "https://tracktor.spotars.lan:3000/locations", { "location": { "bad": "data" } }.to_json
      last_response.status.must_equal 404
    end

    it "responds with status code 400" do
      header "Accept", "application/vnd.spotars.tracktor.v#{valid_version}+json"
      header "Content-Type", "application/json"
      post "https://tracktor.spotars.lan:3000/locations", { "location": { "bad": "data" } }.to_json
      last_response.status.must_equal 400
    end

    it "responds with status code 422" do

      # Will fail because user_id is too long for an integer.
      invalid_body = { "location":
          { "longitude":"11",
          "latitude":"11",
          "bearing":"",
          "recorded_at":"2015-01-29T15:49Z"
      },
          "user_id":"invalid"
      }

      header "Accept", "application/vnd.spotars.tracktor.v#{valid_version}+json"
      header "Content-Type", "application/json"
      post "https://tracktor.spotars.lan:3000/locations", invalid_body.to_json
      last_response.status.must_equal 422
    end
  end
end
