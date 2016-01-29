require 'capybara/rails'
require 'capybara/rspec'
require 'capybara/poltergeist'

# Use Poltergeist as the Capybara JavaScript driver.
Capybara.javascript_driver = :poltergeist
Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, js_errors: true)
end

Capybara.ignore_hidden_elements = true
