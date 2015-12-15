class CommissionProductPolicy < ApplicationPolicy
  def initialize(user, product)
    @user = user
    @product = product
  end

  def new?
    @user
  end

  def create?
    @user
  end

end
