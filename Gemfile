ruby '2.2.3'
source 'https://rubygems.org'

##
# http://rubyonrails.org/
# Rails Guides: http://guides.rubyonrails.org/
# Ruby on Rails, maybe you've heard of it?
gem 'rails', '4.2.5'

##
# API Documentation
gem 'apipony', :git => 'https://github.com/noidedmedia/apipony.git'
##
# https://bitbucket.org/ged/ruby-pg/wiki/Home
# Use Postgres
gem 'pg'

##
# Faster JSON rendering
gem 'yajl-ruby'

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
# https://github.com/arunagw/omniauth-twitter
# Support logging in with Twitter
gem 'omniauth-twitter'

##
# https://github.com/elabs/pundit
# Use Pundit for authorization
gem 'pundit'

##
# https://github.com/svenfuchs/i18n
# Internationalization for Rails
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
gem 'uglifier', '>= 1.3.0'

##
# https://github.com/TannerRogalsky/sprockets-es6
# A Sprockets transformer that converts ES6 code into vanilla ES5 with Babel JS.
gem 'sprockets-es6'

##
# Use TrainTrack to track changes
# (we wrote this!)
gem 'train_track'

##
# https://github.com/vmg/redcarpet
# Use Markdown for user comments
gem 'redcarpet'

##
# https://github.com/newrelic/rpm
# Monitor stuff with New Relic
gem 'newrelic_rpm'

##
# http://unicorn.bogomips.org/
# Use Unicorn as the webserver
gem 'unicorn'

##
# https://github.com/thoughtbot/paperclip
# Use Paperclip to upload images
gem 'paperclip'

##
## https://github.com/wildbit/postmark-rails
# Use Postmark to send email
gem 'postmark-rails'

##
# https://github.com/rails/jquery-rails
# Use jQuery as the JavaScript library
gem 'jquery-rails'

##
# https://github.com/reactjs/react-rails
# React.js for Rails
gem 'react-rails'

##
# https://github.com/rails/turbolinks
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

##
# https://github.com/kossnocorp/jquery.turbolinks
# Fixes issues with JQuery and Turbolinks
gem 'jquery-turbolinks'

##
# https://github.com/norman/friendly_id
# Use friendly IDs for nice URLs
gem 'friendly_id', '~> 5.1.0'

##
# https://github.com/bclubb/possessive
# Possessive gem makes a string possessive
gem 'possessive'

##
# https://github.com/mislav/will_paginate
# Use will-paginate for pagination
gem 'will_paginate', '~> 3.0.6'

##
# https://github.com/rails/jbuilder
# Build JSON APIs with ease.
gem 'jbuilder', '~> 2.0'

##
# https://github.com/ka8725/migration_data
# Change our data in a migration
gem 'migration_data'

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
  # https://github.com/rails/spring
  # Spring speeds up development by keeping your application running in the background.
  gem 'spring'

  ##
  # https://github.com/ngs/hanna-bootstrap
  # Use Hanna Bootstrap theme for RDoc documentation
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
  gem 'rspec-rails', '~> 3.1'

  ##
  # https://github.com/thoughtbot/factory_girl_rails
  gem 'factory_girl_rails'
  
  ##
  # https://github.com/stympy/faker
  # Faker produces fake data for testing/development
  gem 'faker'

  ##
  # https://github.com/sj26/mailcatcher
  # Mailcatcher for confirming that mails work
  # Run `mailcatcher` and visit localhost:1080 to view mail sent during the current session
  gem 'mailcatcher'
end

##
# Test-only gems
group :test do
  # Continue to make tests good
  gem 'shoulda-matchers'
  
  # See how much coverage our tests have
  gem 'simplecov', '~> 0.9.0'
end

##
# Production-only gems
group :production do
  ##
  # https://github.com/heroku/rails_12factor
  gem 'rails_12factor'
end
