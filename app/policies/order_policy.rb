class OrderPolicy < ApplicationPolicy
  def initialize(user, order)
    @user = user
    @order = order
  end

  def show?
    if @order.confirmed?
      owned? or listing_owner?
    else
      owned?
    end
  end

  def update?
    owned? && ! @order.confirmed?
  end

  def purchase?
    @order.confirmed? && 
      @order.accepted? && 
      owned? &&
      @order.charge_id.nil?
  end

  def accept?
    (@order.confirmed? && 
     listing_owner? && 
     ! @order.accepted? &&
     ! @order.rejected?)
  end

  def fill?
    @order.charge_id &&
      listing_owner? &&
      ! @order.filled?
  end

  def create?
    ! listing_owner? && @order.listing.open?
  end

  def confirm?
    owned? && ! @order.confirmed? && ! @order.rejected?
  end

  def reject?
    listing_owner? && @order.confirmed? && ! @order.rejected?
  end

  protected
  
  def owned?
    @order.user == @user
  end

  def listing_owner?
    @order.listing.user == @user
  end

end
