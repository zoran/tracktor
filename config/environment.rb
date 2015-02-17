require File.expand_path('../application', __FILE__)

Rails.application.initialize!

puts "\n\n### Middleware loaded\n"
puts "-" * 80

Rails.configuration.middleware.each do |middleware|
  puts "#{middleware.inspect}"
end

puts "\n\n### Routes loaded"
puts "-" * 80
puts "#{Rails.application.class.name}.routes\n\n\n"
