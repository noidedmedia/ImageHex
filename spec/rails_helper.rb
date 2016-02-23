# frozen_string_literal: true
# This needs to exist apparentlya
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'pundit/rspec'

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    # Choose a test framework:
    with.test_framework :rspec
    with.test_framework :minitest

    with.library :rails
  end
end
