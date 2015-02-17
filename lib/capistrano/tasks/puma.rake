namespace :puma do
  desc "SCP transfer puma configuration to the shared folder"
  task :upload do
    on roles(:app) do
      on host do |host|
        execute :mkdir, "-p", "#{shared_path}/config/"
        upload! "config/puma/#{fetch(:rails_env)}/#{host}/puma.rb", "#{shared_path}/config/puma.rb", via: :scp
      end
    end
  end
end
