ruby '2.2.3'
source 'https://rubygems.org'

gem 'dalli'
##
# http://rubyonrails.org/
# Rails Guides: http://guides.rubyonrails.org/
# Ruby on Rails, maybe you've heard of it?
gem 'rails', '4.2.5'

##
# https://bitbucket.org/ged/ruby-pg/wiki/Home
# Use Postgres
gem 'pg'

##
# https://github.com/aws/aws-sdk-ruby
# Amazon Web Services SDK
gem 'aws-sdk', '< 2.0'

##
# https://github.com/plataformatec/devise
# Devise is "a flexible authentication solution for Rails based on Warden".
# Includes the bcrypt gem for securely storing passwords.
gem 'devise'

##
# Use 2factor authentication
gem 'devise-two-factor'

##
# Use to generate the QR codes for devisee-two-factor
gem 'rqrcode-rails3'

gem 'mini_magick'

##
# Use .env files for development secret keys
# Our real key is set in production
gem 'dotenv-rails', groups: [:development, :test]

##
# https://github.com/elabs/pundit
# Use Pundit for authorization.
gem 'pundit'

##
# https://github.com/svenfuchs/i18n
# Internationalization for Rails.
gem 'i18n'

##
# https://github.com/glebm/i18n-tasks
# Manage translations and localizations
# e.g. `i18n-tasks health` and `i18n-tasks add-missing`
gem 'i18n-tasks'

##
# https://github.com/rails/sass-rails
# Use SCSS for stylesheets
gem 'sass-rails'

##
# https://github.com/lautis/uglifier
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier'

##
# https://github.com/TannerRogalsky/sprockets-es6
# A Sprockets transformer that converts ES6 code into vanilla ES5 with Babel JS.
gem 'sprockets-es6'

##
# https://github.com/AnthonySuper/train_track
# Use TrainTrack to track changes
# NOIDED: We wrote this!
gem 'train_track'

##
# https://github.com/vmg/redcarpet
# Markdown parsing.
gem 'redcarpet'

##
# http://unicorn.bogomips.org/
# Use Unicorn as the webserver.
gem 'unicorn'

##
# https://github.com/thoughtbot/paperclip
# Use Paperclip to upload images.
gem 'paperclip'

##
# https://github.com/rails/jquery-rails
# Use jQuery as the JavaScript library.
gem 'jquery-rails'

##
# https://github.com/reactjs/react-rails
# React.js for Rails
gem 'react-rails'

##
# https://github.com/rails/turbolinks
# Turbolinks makes following links in your web application faster.
# Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

##
# https://github.com/kossnocorp/jquery.turbolinks
# Fixes issues with JQuery and Turbolinks.
gem 'jquery-turbolinks'

##
# https://github.com/norman/friendly_id
# Use friendly IDs for nice URLs.
gem 'friendly_id'

##
# https://github.com/bclubb/possessive
# Possessive gem makes a string possessive.
gem 'possessive'

##
# https://github.com/mislav/will_paginate
# Pagination.
gem 'will_paginate'

##
# https://github.com/rails/jbuilder
# Build JSON APIs with ease.
gem 'jbuilder'

##
# https://github.com/brianmario/yajl-ruby
# Faster JSON rendering.
gem 'yajl-ruby'

##
# https://github.com/ka8725/migration_data
# Change our data in a migration
gem 'migration_data'

##
# https://github.com/droptheplot/apipony
# API Documentation
# NOIDED: We wrote part of this!
gem 'apipony', git: 'https://github.com/noidedmedia/apipony.git'


##
# Development-only gems
group :development do
  gem 'pry-rails'
  gem 'binding_of_caller'
  gem 'reek'
  gem 'rails_best_practices'
  gem 'quiet_assets'
  gem 'better_errors'
  gem 'annotate'
  gem 'bullet'

  ##
  # https://github.com/presidentbeef/brakeman
  # A static analysis security vulnerability scanner for Ruby on Rails applications
  gem 'brakeman'

  ##
  # https://github.com/rails/spring
  # Spring speeds up development by keeping your application running in the background.
  gem 'spring'

  ##
  # https://github.com/ngs/hanna-bootstrap
  # Use Hanna Bootstrap theme for RDoc documentation.
  gem 'hanna-bootstrap'

  ##
  # http://fontcustom.com
  # Use FontCustom for generating the icon font.
  # See the README.md for more on how this works.
  gem 'fontcustom'
end

##
# Development/test gems
group :development, :test do
  ##
  # https://github.com/rspec/rspec-rails
  # A testing framework for Rails.
  gem 'rspec-rails'

  gem 'pry'
  ##
  # https://github.com/thoughtbot/factory_girl_rails
  # A library for setting up Ruby objects as test data.
  gem 'factory_girl_rails'

  ##
  # https://github.com/stympy/faker
  # Faker produces fake data for testing/development.
  gem 'faker'

  ##
  # https://github.com/sj26/mailcatcher
  # Mailcatcher for confirming that mails work.
  # Run `mailcatcher` and visit localhost:1080 to view mail sent during the current session.
  gem 'mailcatcher'
end

##
# Test-only gems
group :test do
  ##
  # https://github.com/thoughtbot/shoulda-matchers
  # Continue to make tests good
  gem 'shoulda-matchers'

  ##
  # https://github.com/colszowka/simplecov
  # See how much coverage our tests have
  gem 'simplecov'
end

##
# Production-only gems
group :production do
  ##
  # https://github.com/heroku/rails_12factor
  gem 'rails_12factor'
end
