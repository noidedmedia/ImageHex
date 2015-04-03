##
# Sends mail to users.
class UserMailer < Devise::Mailer
  include Devise::Mailers::Helpers
  default from: "admin@imagehex.com"
  ##
  # Just invokes super.
  def confirmation_instructions(record, token, other)
    super
  end

  ##
  # just invokes super
  def reset_password_instructions(record, token, other)
    super
  end

  ##
  # Just invokes super
  def unlock_instructions(record, token, other)
    super
  end
end
