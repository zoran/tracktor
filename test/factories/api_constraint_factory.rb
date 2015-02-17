FactoryGirl.define do

  # Default build has an invalid version
  factory :api_constraint do
    version nil
    initialize_with { new(version: version) }
  end
end
