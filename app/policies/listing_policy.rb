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

  def create?
    true
  end

  protected
  def owned?
    @listing.user == @user
  end

end
