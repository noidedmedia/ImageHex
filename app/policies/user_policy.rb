class UserPolicy < ApplicationPolicy
  def initialize(user, valid)
    @validate = valid
    @user = user
  end

  def edit?
    same_user
  end

  def confirm_twofactor?
    same_user && @user.otp_secret && ! @user.two_factor_verified?
  end

  def verify_twofactor?
    same_user && ! @user.two_factor_verified && @user.otp_secret
  end
  def enable_twofactor?
    same_user
  end

  def disable_twofactor?
    same_user
  end
  protected
  def same_user
    @validate == @user
  end
end
