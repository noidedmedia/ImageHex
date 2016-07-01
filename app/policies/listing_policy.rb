class ListingPolicy < ApplicationPolicy
  def initialize(user, listing)
    @listing = listing
    @user = user
  end

  def show?
    true
  end

  def new?
    true
  end

  def close?
    owned?
  end

  def open?
    owned?
  end

  def update?
    owned?
  end

  def confirm?
    signed_in? && 
      (! @user.stripe_user_id.nil?) && 
      owned? && 
      ! @listing.confirmed?
  end

  def create?
    true
  end

  protected
  def owned?
    @listing.user == @user
  end

  def signed_in?
    ! @user.nil?
  end

end
