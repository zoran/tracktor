source 'https://rubygems.org'

gem "rails", "4.1.9"
gem "rgeo"
gem "pg"

# Currently activerecord 4.2 throws "Unknown key: :spatial" on rake db:migrate
gem "activerecord-postgis-adapter" #, github: "rgeo/activerecord-postgis-adapter", branch: "activerecord42"

gem "rgeo-activerecord"
gem "puma"
gem "rack-timeout"
gem "figaro"

group :doc do
  gem "sdoc", require: false
end

group :development, :test do
  gem "awesome_print"
  gem "spring"
  gem "byebug"
  gem "minitest-rails"
  gem "minitest-reporters"
  gem "minitest-byebug"
  gem "database_cleaner"
  gem "factory_girl_rails", require: false
  gem "pry-rails"
  gem "pry-byebug"
  gem "pry-doc"
  gem "ansi"
  gem "multi_json"
  gem "simplecov", require: false
  gem "hirb"
  gem "hirb-unicode"
  gem "capistrano"
  gem "capistrano-rails"
  gem "capistrano-bundler"
  gem "capistrano3-puma", github: "seuros/capistrano-puma"
  gem "capistrano-chruby"
end
