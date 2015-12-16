class CommissionOfferPolicy < ApplicationPolicy
  def initialize(user, offer)
    @user = user
    @offer = offer
  end

  def new?
    not_offering_self?
  end

  def create?
    not_offering_self?
  end

  protected
  def not_offering_self?
    @offer.commission_product.user != @user
  end
end
