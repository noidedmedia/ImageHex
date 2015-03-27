I18n.default_locale = :en
f = Dir[Rails.root.join("config", "locales", "nv", "*.yml")]
I18n.load_path += f
