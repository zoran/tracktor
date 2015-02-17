Rails.application.configure do
  config.eager_load = true # we want this for simplecov
  config.consider_all_requests_local = true
  config.action_dispatch.show_exceptions = false
  config.active_support.test_order = :random
  config.active_support.deprecation = :stderr
  config.valid_subdomains = ["tracktor"]
end
