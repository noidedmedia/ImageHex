class UserMailer < Devise::Mailer
  include Devise::Mailers::Helpers
  default from: "admin@imagehex.com"
  def confirmation_instructions(record, token, other)
    super
  end

  def reset_password_instructions(record, token, other)
    super
  end

  def unlock_instructions(record, token, other)
    super
  end
end
