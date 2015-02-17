Rails.application.configure do
  config.eager_load = false
  config.consider_all_requests_local = true
  config.active_support.deprecation = :log
  config.active_record.migration_error = :page_load
  config.assets.debug = false
  config.assets.digest = false
  config.assets.raise_runtime_errors = true
  config.valid_subdomains = ["tracktor"]
end
