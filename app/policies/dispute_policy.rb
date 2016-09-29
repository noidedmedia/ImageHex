# frozen_string_literal: true
class DisputePolicy < ApplicationPolicy
  class Scope < Scope
    def initialize(user, scope)
      @user, @scope = user, scope
    end

    def resolve
      if @user.admin?
        @scope.all
      else
        @scope.joins(:order).where(orders: {user_id: @user.id})
      end
    end
  end

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
