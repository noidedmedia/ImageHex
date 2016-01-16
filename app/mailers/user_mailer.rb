##
# Sends mail to users.
class UserMailer < ApplicationMailer
  def enable_twofactor(user)
    @user = user
    mail(to: @user.email, subject: 'Two-Factor Authentication enabled for your account')
  end

  def disable_twofactor(user)
    @user = user
    mail(to: @user.email, subject: 'Two-Factor Authentication disabled for your account')
  end
end
