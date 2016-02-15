Rails.application.configure do
  Bullet.enable = true
  Bullet.alert = false
  Bullet.console = true

  # Settings specified here will take precedence over those in config/application.rb.
  config.action_mailer.default_url_options = { host: 'localhost:3000' }
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = { address: "localhost", port: 1025 }

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false
  config.paperclip_defaults = {
    path: "public/system/fs/:class/:id_:style.:extension",
    url: "/system/fs/:class/:id_:style.:extension"
  }
  ##
  # Hack to get images to work properly in development
  $IMAGE_PATH = "public/system/fs/:class/:id_:style.:extension"
  $SUBJECT_REF_PATH = "public/system/fs/:class/:id_:style.:extension"
  $AVATAR_PATH = "public/system/fs/:class/:id_:style.:extension"
  $BACKGROUND_REF_PATH = $SUBJECT_REF_PATH

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  # Adds additional error checking when serving assets at runtime.
  # Checks for improperly declared sprockets dependencies.
  # Raises helpful error messages.
  config.assets.raise_runtime_errors = true

  # Disables Autoprefixer for the development environment.
  config.assets.unregister_postprocessor('text/css', :autoprefixer)

  # Raises error for missing translations
  config.action_view.raise_on_missing_translations = true
end
