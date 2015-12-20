# Be sure to restart your server when you modify this file.

# Configure sensitive parameters which will be filtered from the log file.
Rails.application.config.filter_parameters += [:password, :encrypted_password, :encrypted_otp_secret, :encrypted_otp_secret_iv, :encrypted_otp_secret_salt, :otp_backup_codes, :confirmation_token]
