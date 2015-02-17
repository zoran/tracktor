FactoryGirl.define do

  # Default build is valid
  factory :api_sub_domain_constraint do
    subdomain = Rails.configuration.valid_subdomains.first
    initialize_with { new(subdomain) }
  end
end
