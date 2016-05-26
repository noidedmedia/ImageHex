class OrderPolicy < ApplicationPolicy
  def initialize(user, order)
    @user = user
    @order = order
  end

  def show?
    owned? or listing_owner?
  end

  def create?
    ! listing_owner?
  end

  def confirm?
    owned? && unconfirmed?
  end

  protected
  def unconfirmed?
    ! @order.confirmed?
  end

  def owned?
    @order.user == @user
  end

  def listing_owner?
    @order.listing.user == @user
  end

end
