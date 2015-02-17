class Tracktor::V1::LocationsController < ApplicationController

  # This is an API and we don't want run into
  #   "Can't verify CSRF token authenticity"
  skip_before_filter :verify_authenticity_token, only: [:options, :create]

  before_filter :set_access_control_headers,
      :parse_request

  def options
    render nothing: true
  end

  # We don't have to care about strong parameters
  # here since we assign attributes directly.
  def create
    if processible_post?
      @location = Location.new(tracktor_api_subdomain: params["subdomain"],
          location: build_gis_point,
          user_id: @request_body[:user_id],
          recorded_at: @request_body[:location][:recorded_at],
          bearing: @request_body[:location][:bearing],
          tracktor_api_ver: get_api_version)
      begin
        if @location.save

          # status should be :created (201) but we must use :ok (200) here because the
          # cordova plugin "cordova-plugin-background-geolocation" is caching records
          # locally (sqlite) on the device if its not able to post to this API. As soon
          # as the device gets an network connection and its able to post to the API it
          # expects a status code 200 which will trigger the plugin to clear the
          # cache on the device.
          render nothing: true, status: 200
        else
          render json: { errors: @location.errors }, status: 422
        end
      rescue
        render nothing: true, status: 422
      end
    else
      render nothing: true, status: 400
    end
  end

private

  # Don't use line breaks here
  def set_access_control_headers
    headers["Accept-Encoding"] = "gzip,deflate"
    headers["Accept-Charset"] = "utf-8"
    headers["X-Frame-Options"] = "DENY"
    headers["Access-Control-Allow-Methods"] = "OPTIONS, POST"
    headers["Access-Control-Allow-Headers"] = "Origin, Content-Type, Accept, Authorization"

    # Enable this for HTTPS
    #headers["Strict-Transport-Security"] = "max-age=31536000;
    #    includeSubDomains; preload"

    #headers["Access-Control-Allow-Origin"] = "*"
  end

  # Recursively check values and turn them into stripped strings
  def parse_request
    @request_body = JSON.parse(request.body.read)
        .deep_symbolize_keys rescue nil
  end

  # Quick presence validation of mandatory attributes here allows
  # us to immediately return code 4xx on invalid post calls.
  # The values checked here don't have to be valid (from model's
  # perspective) at this point because some of them are sanitized
  # in the model before they get saved.
  def processible_post?
    @request_body &&
        @request_body[:location] &&
        @request_body[:user_id] &&
        @request_body[:location][:recorded_at]
  end

  def build_gis_point
    "POINT(#{@request_body[:location][:longitude]}
        #{@request_body[:location][:latitude]})"
  end

  def get_api_version
    self.class.name.split("::")[1].downcase
  end
end
