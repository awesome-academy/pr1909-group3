# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.5'

gem 'activerecord-import'
gem 'bcrypt', '~> 3.1.7'
gem 'bootsnap', '>= 1.1.0', require: false
gem 'bootstrap-kaminari-views'
gem 'bootstrap-sass', '3.3.7'
gem 'bootstrap3-datetimepicker-rails', '~> 4.17.47'
# Tao duong dan than thien
gem 'stringex'
# gem "cancancan"
# Gem su dung de dung cho aws3
gem 'aws-sdk'
gem 'carrierwave'
gem 'chartkick'
gem 'chatwork'
gem 'ckeditor'
# gem 'coffee-rails', '~> 4.2'
gem 'config'
# Gem su dung trong phan bau chon
gem 'counter_culture', '~> 2.0'
gem 'devise'
gem 'dropzonejs-rails', '~> 0.7.3'
gem 'execjs'
gem 'faker', '1.7.3'
gem 'figaro', '~> 1.1', '>= 1.1.1'
gem 'font-awesome-rails', '~> 4.7', '>= 4.7.0.1'
gem 'gon'
gem 'groupdate' # Gem tao do thi
gem 'image_processing' # Tai tep tin di kem voi gem shrine
gem 'jbuilder', '~> 2.5'
gem 'jquery-rails', '~> 4.3', '>= 4.3.3'
# Su dung de phan trang
gem 'kaminari'
# Xu li anh voi rails
gem 'mini_magick', '~> 4.8'
# Gem de su dung cho lich
gem 'momentjs-rails', '>= 2.9.0'
gem 'mysql2', '>= 0.4.4', '< 0.6.0'
# Gem de dang nhap bang facebook
gem 'omniauth'
gem 'omniauth-facebook'
gem 'omniauth-google-oauth2'
gem 'pry'
gem 'puma', '~> 3.11.4' # Gem tang hieu suat lam viec
gem 'rails', '~> 5.2.0'
gem 'redis', '~> 3.0'
gem 'redis-namespace'
gem 'redis-rack-cache'
gem 'redis-rails'
gem 'roo' # Hai gem dung de import data tu file excel
gem 'roo-xls'
gem 'rubocop', '~> 0.54.0', require: false
gem 'sass-rails', '~> 5.0'
gem 'select2-rails'
gem 'sendgrid'
gem 'shrine' # Gem nay de tai anh len
gem 'sidekiq' # Gem chay background job
gem 'therubyracer'
gem 'uglifier', '>= 1.3.0' # Gem de nen file js
gem 'whenever', require: false

group :development, :test do
  gem 'byebug', platforms: %i(mri mingw x64_mingw)
end

group :development do
  gem 'capistrano', '~> 3.11.0',        require: false
  gem 'capistrano-bundler', '~> 1.3.0', require: false
  gem 'capistrano-rails', '~> 1.4.0',   require: false
  gem 'capistrano-rvm', '~> 0.1.2',     require: false
  gem 'capistrano3-puma', '~> 3.1.1',   require: false
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

group :test do
  gem 'capybara', '>= 2.15', '< 4.0'
  gem 'chromedriver-helper'
  gem 'selenium-webdriver'
end

gem 'tzinfo-data', platforms: %i(mingw mswin x64_mingw jruby)

group :production do
  gem 'mysql2', '>= 0.4.4', '< 0.6.0'
end
