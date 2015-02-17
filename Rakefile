require File.expand_path("../config/application", __FILE__)

Rails.application.load_tasks

desc "List all available rake tasks"
task :help do
  system("rake -T")
end

# Don't run any tests when executing just "rake".
task(:default).clear

task default: :help
