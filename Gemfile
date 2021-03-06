source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.1.4'
gem 'pg'
gem 'puma', '~> 3.7'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem 'devise'
gem 'jwt'
gem 'active_model_serializers', '~> 0.10.0'
gem 'stripe'
gem 'figaro'
gem 'opentok', "~> 3.0.2"
gem 'apipie-rails'
gem 'rack-cors'
gem 'redis'
gem 'aws-sdk', '~> 2'
gem 'carrierwave', '~> 1.0'
gem "fog-aws"
gem 'gibbon'
gem 'carrierwave-base64'
gem 'sentry-raven'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
  gem 'database_cleaner'
  gem 'factory_bot'
  gem 'faker'
  gem 'rspec-rails'
  gem 'dotenv-rails'
  gem 'shoulda-matchers', '~> 3.1'
  gem 'pry-byebug'
end

group :development do
  gem 'pry-byebug'
  gem 'web-console', '>= 3.3.0'
  gem 'pry'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'rails-erd', require: false
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
