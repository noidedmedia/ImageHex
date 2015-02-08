source 'https://rubygems.org'
ruby '2.1.5'

gem 'devise'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.0'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.3'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer',  platforms: :ruby

##
# Use friendly IDs for nice URLs
gem 'friendly_id', '~> 5.1.0'

# Possessive gem makes a string possessive
gem "possessive"
# Monitor stuff with new relic
gem 'newrelic_rpm'

# Use postgres
gem 'pg'
# Use will-paginate for pagination
gem 'will_paginate', "~> 3.0.6"

# Use unicorn as the webserver
gem 'unicorn'
# Use paperclip to upload images
gem 'paperclip'

# Use postmark to send email
gem 'postmark-rails'
# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Fixes issues with JQuery and Turbolinks, read more: https://github.com/kossnocorp/jquery.turbolinks
gem 'jquery-turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0',          group: :doc

# Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
gem 'spring',        group: :development

# Use AWS for storage
gem 'aws-sdk'

# Make tests good!
group :development, :test do
  gem 'rspec-rails', '~> 3.1'
  gem 'factory_girl_rails'
  gem 'faker'
  gem "mailcatcher" # to confirm mails
end

group :development do
  gem 'reek'
  gem 'rails_best_practices'
  gem 'quiet_assets'
  gem 'better_errors'
  gem 'annotate'
  gem 'bullet'
end
group :test do
  # Continue to make tests good
  gem 'shoulda-matchers'
  # See how much coverage our tests have
  gem 'simplecov', '~> 0.9.0'
end
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

gem 'rails_12factor', group: :production
# Use debugger
# gem 'debugger', group: [:development, :test]

