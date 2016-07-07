class ListingPolicy < ApplicationPolicy
  def initialize(user, listing)
    @listing = listing
    @user = user
  end

  def show?
    (@listing.open? && @listing.confirmed?) || owned?
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
    (owned? && 
      @user.stripe_user_id && 
      ! @listing.confirmed?)
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
