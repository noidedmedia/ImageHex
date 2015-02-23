require File.expand_path('../boot', __FILE__)

##
# Add our ImageHex helper library
require_relative '../lib/image_hex/image_hex.rb'
require 'rails/all'
# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ImageHex
  class Application < Rails::Application
    config.active_record.raise_in_transactional_callbacks = true
    routes.default_url_options[:host] = "localhost"
    ##
    # Use Postmark to send emails
    config.action_mailer.delivery_method = :postmark
    config.action_mailer.postmark_settings = {api_key: ENV['POSTMARK_API_KEY']}
    config.assets.paths << Rails.root.join("app", "assets", "fonts")
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de
  end
end
