class CommissionOfferPolicy < ApplicationPolicy
  def initialize(user, offer)
    @user = user
    @offer = offer
  end

  def new?
    not_offering_self?
  end

  def confirm? 
    res = unconfirmed? && owner?
  end

  def accept?
    @offer.confirmed? && offeree? && ! @offer.accepted?
  end

  def pay?
    charge?
  end

  def charge?
    owner? && @offer.accepted?
  end

  def create?
    not_offering_self? 
  end

  def update?
    owner? && unconfirmed?
  end

  def show?
    if @offer.confirmed?
      owner? || offeree?
    else
      owner?
    end
  end

  protected
  def unconfirmed?
    ! @offer.confirmed?
  end

  def owner?
    @offer.user == @user
  end

  def offeree? 
    @offer.commission_product.user == @user
  end

  def not_offering_self?
    ! offeree? 
  end

end
