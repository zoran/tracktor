require "simplecov"

ENV["RAILS_ENV"] = "test"

# Start coverage as soon as possible
SimpleCov.start do
  coverage_dir "tmp/coverage"
  SimpleCov.use_merging false

  add_group "Constraints", "app/constraints"
  add_group "Controllers", "app/controllers"
  add_group "Models", "app/models"
  add_group "Validations", "app/validations"
  add_group "Rakefile", "Rakefile"

  # Exclude these paths from analysis
  add_filter "app/views"
  add_filter "bin"
  add_filter "test"
  add_filter "vendor"
  add_filter "config"
end

require File.expand_path("../../config/environment", __FILE__)
require "rails/test_help"
require "minitest/rails"
require "minitest/reporters"
require "minitest/autorun"
require "factory_girl_rails"
require "database_cleaner"

Rails.backtrace_cleaner.remove_silencers!

Minitest::Reporters.use!(
  Minitest::Reporters::SpecReporter.new,
  ENV,
  Minitest.backtrace_filter
)

class ActiveSupport::TestCase
  ActiveRecord::Migration.check_pending!
  include FactoryGirl::Syntax::Methods
  DatabaseCleaner[:active_record].strategy = :transaction
end

class MiniTest::Spec
  include FactoryGirl::Syntax::Methods
  before { DatabaseCleaner.start }
  after { DatabaseCleaner.clean }
end

class MiniTest::Test
  include FactoryGirl::Syntax::Methods
end

def app
  Rack::Builder.parse_file('config.ru').first
end
