set :rack_env, "staging"
set :rails_env, fetch(:rack_env)
set :environment, fetch(:rails_env)
set :stage, fetch(:rails_env)
set :branch, fetch(:rails_env)
set :keep_releases, 7
set :log_level, :info
set :default_env, {}
set :deploy_user, "tracktor"
set :full_app_name, "#{ fetch(:application) }_#{ fetch(:rails_env) }"
set :puma_conf, -> { File.join(shared_path, "config", "puma.rb") }
set :linked_files, %W{ config/puma.rb config/application.yml }
set :deploy_to, "/home/#{ fetch(:deploy_user) }/apps/#{ fetch(:full_app_name) }"

server "tracktor-stag-1.spotars.com",
    roles: %w{ app db },
    user: fetch(:deploy_user),
    server_name: "tracktor-stag-1.spotars.com",
    primary: true,
    ssh_options: {
      keys: %W(/home/zoran/Dropbox/Dev/Projects/spotars/ops/keys/ec2/tracktor),
      forward_agent: true,
      auth_methods: %w(publickey)
    }

server "tracktor-stag-2.spotars.com",
    roles: %w{ app },
    user: fetch(:deploy_user),
    server_name: "tracktor-stag-2.spotars.com",
    primary: false,
    ssh_options: {
    keys: %W(/home/zoran/Dropbox/Dev/Projects/spotars/ops/keys/ec2/tracktor),
    forward_agent: true,
    auth_methods: %w(publickey)
}
