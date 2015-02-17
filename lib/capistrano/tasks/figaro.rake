namespace :figaro do
  desc "SCP transfer figaro configuration to the shared folder"
  task :upload do
    on roles(:app) do
      execute :mkdir, "-p", "#{shared_path}/config/"
      upload! "config/application.yml", "#{shared_path}/config/application.yml", via: :scp
    end
  end
end
