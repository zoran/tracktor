if %w(staging production).include? Rails.env
  Figaro.require_keys("rails_secret_key", "db_main_host", "db_main_user_name", "db_main_password")
end
