# frozen_string_literal: true
class CommissionProductPolicy < ApplicationPolicy
  def initialize(user, product)
    @user = user
    @product = product
  end

  def create?
    @user
  end

  def confirm?
    verified_user_info?
  end

  def update?
    @product.user == @user
  end

  protected

  def verified_user_info?
    @user.stripe_user_id && @user.stripe_publishable_key
  end
end
