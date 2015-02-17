# config valid only for current version of Capistrano
lock "3.3.5"

set :shell, "/bin/bash"
set :application, "tracktor"
set :repo_url, "git@github.com:zoran/tracktor.git"
set :scm, :git
set :git_shallow_clone, 1
set :copy_cache, true
set :format, :pretty
set :log_level, :warn
set :default_stage, "staging"
set :pty, false
set :linked_dirs, %w{ log tmp/pids tmp/cache tmp/sockets vendor }

# Bundler
set :bundle_roles, :all
set :bundle_servers, -> { release_roles(fetch(:bundle_roles)) }
set :bundle_binstubs, nil
set :bundle_gemfile, -> { release_path.join("Gemfile") }
set :bundle_path, -> { shared_path.join("vendor/bundle") }
set :bundle_without, %w{ development test production }.join(" ")
set :bundle_jobs, 2
set :bundle_flags, "--deployment --quiet"
set :bundle_env_variables, {}

# Upload config/application.yml
after "deploy:check:make_linked_dirs", "figaro:upload"

# Upload puma config
after "deploy:check:make_linked_dirs", "puma:upload"
