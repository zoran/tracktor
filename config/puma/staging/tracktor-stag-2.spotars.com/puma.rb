directory '/home/tracktor/apps/tracktor_staging/current'
rackup "/home/tracktor/apps/tracktor_staging/current/config.ru"
environment 'staging'
state_path "/home/tracktor/apps/tracktor_staging/shared/tmp/pids/puma.state"
stdout_redirect '/home/tracktor/apps/tracktor_staging/shared/log/puma_access.log', '/home/tracktor/apps/tracktor_staging/shared/log/puma_error.log', true
pidfile "/home/tracktor/apps/tracktor_staging/shared/tmp/pids/puma.pid"
tag "Spotars Tracktor Server - Staging"
bind "tcp://tracktor-stag-2.spotars.com:8080"
threads 8,8
workers 2
daemonize true
worker_timeout 30
preload_app!

on_worker_boot do
  ActiveSupport.on_load(:active_record) do
    ActiveRecord::Base.establish_connection
  end
end
