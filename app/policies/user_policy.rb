class UserPolicy < ApplicationPolicy
  def initialize(user, valid)
    @validate = valid
    @user = user
  end

  def update?
    same_user
  end
  protected
  def same_user
    @validate == @user
  end
end
