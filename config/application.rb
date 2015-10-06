require File.expand_path('../boot', __FILE__)

require 'rails/all'

##
# Add the Markdown Handler in '../lib/handlers/'.
# For use on the About and FAQ pages.
require_relative '../lib/handlers/markdown_handler.rb'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ImageHex
  class Application < Rails::Application
    config.autoload_paths << Rails.root.join("lib")
    config.active_record.raise_in_transactional_callbacks = true
    routes.default_url_options[:host] = "localhost"

    config.generators.javascript_engine :js
    ##
    # Use Postmark to send emails
    config.action_mailer.delivery_method = :postmark
    config.action_mailer.postmark_settings = {api_key: ENV['POSTMARK_API_KEY']}
    config.assets.paths << Rails.root.join("app", "assets", "fonts")
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Suggested by Thoughtbot, compresses your content with gzip.
    # https://robots.thoughtbot.com/content-compression-with-rack-deflater
    config.middleware.use Rack::Deflater

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # Custom i18n routes.
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')]
  end
end
