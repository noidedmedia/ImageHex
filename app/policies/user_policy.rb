# frozen_string_literal: true
class UserPolicy < ApplicationPolicy
  def initialize(user, valid)
    @validate = valid
    @user = user
  end

  ##
  # Checks that user owns the account they're modifying.
  def update?
    same_user
  end

  ##
  # Confirm that provided two-factor authentication code matches OTP key for
  # a given user.
  # Requires that two-factor authentication hasn't been enabled and ownership of
  # the account being modified.
  def confirm_twofactor?
    same_user && @user.otp_secret && !@user.two_factor_verified?
  end

  ##
  # Page displays steps to enable two-factor authentication and input field.
  # Requires that two-factor authentication hasn't been enabled and ownership of
  # the account being modified.
  def verify_twofactor?
    same_user && !@user.two_factor_verified && @user.otp_secret
  end

  ##
  # Checks that the user owns the account they're modifying before enabling
  # two-factor authentication.
  def enable_twofactor?
    same_user
  end

  ##
  # Checks that the user owns the account they're modifying before disabling
  # two-factor authentication.
  def disable_twofactor?
    same_user
  end

  protected

  ##
  # Convenience method for checking if the user owns the account.
  def same_user
    @validate == @user
  end
end
