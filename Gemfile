source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.3'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0.0'
# Use Puma as the app server
gem 'puma', '~> 4.3', '>= 4.3.1'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false

gem 'carrierwave', '~> 2.0', '>= 2.0.2'
gem 'mini_magick', '~> 4.9', '>= 4.9.5'
gem 'kaminari', '~> 1.2'
gem 'devise', '~> 4.7', '>= 4.7.1'
gem 'webpacker', '~> 4.2', '>= 4.2.2'
gem 'rails-i18n', '~> 6.0'
gem 'devise-i18n', '~> 1.8', '>= 1.8.2'
gem 'devise-i18n-views', '~> 0.3.7'
gem 'devise-bootstrap-views', '~> 1.1'
gem 'pg', '~> 1.1', '>= 1.1.4'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails', '~> 3.9'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  
  gem 'capistrano', '~> 3.11', '>= 3.11.2'
  gem 'capistrano-rails', '~> 1.4'
  gem 'capistrano-bundler', '~> 1.6'
  gem 'capistrano-rbenv', '~> 2.1', '>= 2.1.4'
  gem 'capistrano-rbenv-vars', '~> 0.1.0'
  gem 'capistrano3-puma', '~> 4.0'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'webdrivers', require: !ENV['SELENIUM_REMOTE_URL']
  gem 'factory_bot_rails', '~> 5.1', '>= 5.1.1'
  gem 'rspec_junit_formatter', '~> 0.4.1'
end

group :production do
  gem 'fog', '~> 2.2'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]