# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.4.2'

gem 'bootsnap', '>= 1.1.0', require: false
gem 'coffee-rails', '~> 4.2'
gem 'devise'
gem 'jbuilder', '~> 2.5'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 3.11'
gem 'rails', '~> 5.2.0'
gem 'sass-rails', '~> 5.0'
gem 'slim-rails'
gem 'uglifier', '>= 1.3.0'

gem 'bootstrap'
gem 'jquery-rails'

gem 'carrierwave'
gem 'remotipart'
gem 'cocoon'
gem 'acts_as_votable'

gem 'skim'
gem 'gon'
gem 'responders'
gem 'omniauth'
gem 'omniauth-facebook'
gem 'omniauth-twitter'
gem 'omniauth-github'
gem 'cancancan'
gem 'doorkeeper'
gem 'oj'
gem 'oj_mimic_json'
gem 'active_model_serializers', '~> 0.10.7'

gem 'sidekiq'
gem 'sinatra', require: false
gem 'whenever', require: false

gem 'mysql2', :platform => :ruby
gem 'jdbc-mysql', :platform => :jruby
gem 'thinking-sphinx'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'capybara'
  gem 'capybara-webkit'
  gem 'capybara-email'
  gem 'database_cleaner'
  gem 'factory_bot_rails'
  gem 'pry-byebug'
  gem 'rails-controller-testing'
  gem 'rspec-rails'
  gem 'rubocop'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
  gem 'letter_opener'
end

group :test do
  # gem 'selenium-webdriver'
  gem 'chromedriver-helper'
  gem 'launchy'
  gem 'shoulda-matchers', require: false
  gem 'json_spec'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
