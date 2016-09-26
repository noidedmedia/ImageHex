# frozen_string_literal: true
require 'simplecov'
SimpleCov.start if ENV["COVERAGE"]

ENV["RAILS_ENV"] ||= 'test'

require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require "paperclip/matchers" # Make testing paperclip stuff much easier

Capybara.javascript_driver = :webkit

Capybara::Webkit.configure do |config|
  config.allow_url("js.stripe.com")
end

# Requires supporting ruby files with custom matchers and macros, etc, in
# spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

RSpec.configure do |config|
  config.include Rails.application.routes.url_helpers
  config.include Paperclip::Shoulda::Matchers
  config.include FileHelper

  config.mock_with :rspec
  config.use_transactional_fixtures = false

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    # set the default
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, type: :feature) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.append_after(:each) do
    DatabaseCleaner.clean
  end



  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"


  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = "random"

  config.infer_spec_type_from_file_location!

  config.before(:each, type: :feature) do
    Paperclip.is_in_feature_spec = true
  end

  config.after(:each) do
    Warden.test_reset!
  end

  config.after(:each, type: :feature) do
    Paperclip.is_in_feature_spec = false
  end
end

ActiveRecord::Migration.maintain_test_schema!
