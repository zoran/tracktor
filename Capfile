require "capistrano/setup"
require "capistrano/deploy"
require "capistrano/bundler"
require "capistrano/puma"
require "capistrano/rails/migrations"
require "capistrano/chruby"

Dir.glob("lib/capistrano/tasks/*.rake").each { |r| import r }

set :chruby_ruby, File.read(".ruby-version").chomp
