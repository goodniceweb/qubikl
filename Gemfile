source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.2.2'

gem 'puma', '~> 5.0'
gem 'rails', '~> 7.1.2'
gem 'sass-rails', '>= 6'
gem 'webpacker', '~> 5.0'

gem 'cancancan'
gem 'carrierwave', '~> 3.0.3'
gem 'chartkick'
gem 'devise'
gem 'jsonapi-rails'
gem 'maxmind-geoip2'
gem 'pg'
gem 'rack-cors'
gem 'rqrcode'
gem 'sidekiq'
gem 'stimulus-rails'
gem 'swagger-blocks'
gem 'swagger-ui_rails'
gem 'user_agent_parser'

gem 'bootsnap', '>= 1.4.4', require: false

group :development, :test do
  gem 'pry-rails'
end

group :development do
  gem 'web-console', '>= 4.1.0'
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'listen', '~> 3.3'
  gem 'spring'
end

group :test do
  gem 'capybara', '>= 3.26'
  gem 'selenium-webdriver'
  gem 'webdrivers'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

gem "importmap-rails", "~> 1.2"
