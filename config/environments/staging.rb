Rails.application.configure do
  config.eager_load = true
  config.consider_all_requests_local = false
  config.force_ssl = false
  config.log_level = :warn
  config.log_tags = [ :subdomain, :uuid ]
  config.i18n.fallbacks = true
  config.active_support.deprecation = :notify
  config.log_formatter = ::Logger::Formatter.new
  config.active_record.dump_schema_after_migration = false
  config.valid_subdomains = %w(tracktor-stag)
end
