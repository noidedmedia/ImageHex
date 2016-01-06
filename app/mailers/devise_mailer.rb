##
# Sends mail to users.
class DeviseMailer < Devise::Mailer
  include Devise::Mailers::Helpers
  default from: "ImageHex <noreply@imagehex.com>"
  layout "mailer"
  
  ##
  # Just invokes super.
  def confirmation_instructions(record, token, other)
    super
  end

  ##
  # Just invokes super
  def reset_password_instructions(record, token, other)
    super
  end

  ##
  # Just invokes super
  def unlock_instructions(record, token, other)
    super
  end
end
