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

  def update?
    owned?
  end

  def confirm?
    ! @user.stripe_user_id.nil?
  end

  def create?
    true
  end

  protected
  def owned?
    @listing.user == @user
  end

end
