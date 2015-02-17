FactoryGirl.define do

  # Default build is valid
  factory :location do
    location "POINT(10 50)"
    user_id 123
    tracktor_api_ver "v1"
    recorded_at Time.now.utc
    bearing 360
  end
end
