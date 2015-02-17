require File.expand_path("../boot", __FILE__)

require "active_record/railtie"
require "action_controller/railtie"
require "active_model/railtie"

# keep this otherwise "rake test" will run in development ENV
require "rails/test_unit/railtie"

Bundler.require(*Rails.groups)

module Tracktor
  class Application < Rails::Application
    config.middleware.delete "Rack::Lock"
    config.middleware.delete "Rack::ETag"
    config.middleware.delete "Rack::Sendfile"
    config.middleware.delete "Rack::ConditionalGet"
    config.middleware.delete "Rack::Head"
    config.middleware.delete "Rack::MethodOverride"
    config.middleware.delete "ActiveRecord::QueryCache"
    config.middleware.delete "ActionDispatch::Static"
    config.middleware.delete "ActionDispatch::Flash"
    config.middleware.delete "ActionDispatch::Cookies"
    config.middleware.delete "ActionDispatch::Session::CookieStore"
    config.middleware.delete "ActionDispatch::ShowExceptions"
    config.middleware.delete "ActionDispatch::DebugExceptions"
    config.middleware.delete "ActionDispatch::Reloader"
    config.middleware.swap ActionDispatch::ParamsParser, ActionDispatch::ParamsParser, Mime::JSON => nil

    config.active_record.default_timezone = :utc
    config.eager_load_paths += %W(\#{config.root}/lib)

    # Enable this for HTTPS
    #config.force_ssl = true

    # Note that this option was added as a security measure, to ensure user
    # input cannot be used as locale information unless it is previously known.
    # Therefore, it's recommended not to disable this option unless
    # you have a strong reason for doing so.
    config.i18n.enforce_available_locales = true
    config.i18n.default_locale = :en
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '*.{rb,yml}').to_s]

    # Use Minitest for generating new tests.
    config.generators do |g|
      g.test_framework :minitest, spec: true
      g.fixture_replacement :factory_girl, dir: 'test/factories'
      g.view_specs false
      g.helper_specs false
      g.assets false
      g.stylesheets false
      g.javascripts false
      g.helper false
    end
  end
end
