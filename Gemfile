# frozen_string_literal: true
ruby '2.3.0'
source 'https://rubygems.org'

##
# http://rubyonrails.org/
# Rails Guides: http://guides.rubyonrails.org/
# Ruby on Rails, maybe you've heard of it?
gem 'rails', git: 'https://github.com/rails/rails.git'

##
# https://bitbucket.org/ged/ruby-pg/wiki/Home
# Use Postgres for our database
gem 'pg'

##
# https://github.com/aws/aws-sdk-ruby
# Amazon Web Services SDK
gem 'aws-sdk', '~> 2.0'

##
# Use Stripe
gem 'stripe'

##
# Use Omniauth with Stripe
gem 'oauth2'

##
# https://github.com/plataformatec/devise
# Devise is "a flexible authentication solution for Rails based on Warden".
# Includes the bcrypt gem for securely storing passwords.
gem 'devise', '>= 4.0.0.rc1'

##
# https://github.com/tinfoil/devise-two-factor
# Two-factor authentication support for devise
gem 'devise-two-factor', git: 'https://github.com/connorshea/devise-two-factor.git', branch: 'patch3'

##
# https://github.com/samvincent/rqrcode-rails3
# Used to generate the QR codes for devise-two-factor.
gem 'rqrcode-rails3'

##
# https://github.com/minimagick/minimagick
# A ruby wrapper for ImageMagick, required for rqrcode-rails3.
gem 'mini_magick'

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
gem 'sass-rails', '6.0.0.beta1'

##
# https://github.com/lautis/uglifier
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier'

##
# https://github.com/rails/sprockets
# Rack-based asset packaging system
gem 'sprockets', '4.0.0.beta2'

##
# https://github.com/babel/ruby-babel-transpiler
# A Babel Transpiler that converts ES6 code into vanilla ES5 with Babel JS.
gem 'babel-transpiler'

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
gem 'turbolinks', '5.0.0.beta2'

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
gem 'apipony'

##
# https://github.com/petergoldstein/dalli
# High performance memcached client for Ruby
gem 'dalli'

##
# https://github.com/brigade/scss-lint
# Configurable tool for writing clean and consistent SCSS
# Config file: `config/scss_lint.yml`
# Run linter with `rake scss:lint`
gem 'scss_lint', require: false

##
# https://github.com/ai/autoprefixer-rails
# Automatically adds vendor prefixes to CSS with the Asset Pipeline.
# View what Autoprefixer will change with `rake autoprefixer:info`.
# Config file: `config/autoprefixer.yml`
gem 'autoprefixer-rails'

##
# Development-only gems
group :development do
  ##
  # https://github.com/bbatsov/rubocop
  # A Ruby static code analyzer based on the community Ruby style guide.
  # Config file: `.rubocop.yml`
  # Run Rubocop with `rake rubocop`
  gem 'rubocop'

  ##
  # https://github.com/rweng/pry-rails
  # Use Pry as your Rails console.
  gem 'pry-rails'

  ##
  # https://github.com/banister/binding_of_caller
  # Retrieve the binding of a method's caller in MRI 1.9.2+.
  gem 'binding_of_caller'

  ##
  # https://github.com/railsbp/rails_best_practices
  # A code metric tool for rails projects.
  gem 'rails_best_practices'

  ##
  # Mutes asset pipeline log messages.
  # https://github.com/evrone/quiet_assets
  gem 'quiet_assets'

  ##
  # https://github.com/charliesome/better_errors
  # Better error page for Rack apps.
  gem 'better_errors'

  ##
  # https://github.com/ctran/annotate_models
  # Annotates Rails/ActiveRecord Models, routes, fixtures, and others based on the database schema.
  gem 'annotate'

  ##
  # https://github.com/flyerhzm/bullet
  # Help to kill N+1 queries and unused eager loading.
  gem 'bullet'

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
  gem 'rspec-rails', '>= 3.5.0.beta1'

  ##
  # https://github.com/pry/pry
  # An IRB alternative and runtime developer console.
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
  # https://github.com/bkeepers/dotenv
  # Use .env files for development secret keys
  # Our real key is set in production
  gem 'dotenv-rails'

  ##
  # https://github.com/presidentbeef/brakeman
  # A static analysis security vulnerability scanner for Ruby on Rails applications
  gem 'brakeman'

  ##
  # https://github.com/rubysec/bundler-audit
  # Patch-level verification for Bundler
  gem 'bundler-audit'

  ##
  # https://github.com/jnicklas/capybara
  # Acceptance test framework for web applications
  gem 'capybara'

  ##
  # https://github.com/mattheworiordan/capybara-screenshot
  # Automatically save screen shots when a Capybara scenario fails
  gem 'capybara-screenshot'

  ##
  # https://github.com/teampoltergeist/poltergeist
  # A PhantomJS driver for Capybara
  gem 'poltergeist'
end

##
# Test-only gems
group :test do
  ##
  # https://github.com/travisjeffery/timecop
  # A gem providing "time travel", "time freezing", and "time acceleration" capabilities.
  gem 'timecop'

  ##
  # https://github.com/thoughtbot/shoulda-matchers
  # Continue to make tests good
  gem 'shoulda-matchers'

  ##
  # https://github.com/colszowka/simplecov
  # See how much coverage our tests have
  gem 'simplecov'

  ##
  # https://github.com/rails/rails-controller-testing
  # Extracting `assigns` and `assert_template` from ActionDispatch.
  gem 'rails-controller-testing'
end

##
# Production-only gems
group :production do
  ##
  # https://github.com/heroku/rails_12factor
  #
  gem 'rails_12factor'
end
