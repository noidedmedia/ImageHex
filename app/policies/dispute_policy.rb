class DisputePolicy < ApplicationPolicy
  def initialize(user, d)
    @user = user
    @dispute = d
  end

  def show?
    @user.admin? || is_commissioner?
  end

  def create?
    is_commissioner?
  end

  protected
  def is_commissioner?
    @dispute.commission_offer.try(:user) == @user
  end


end
