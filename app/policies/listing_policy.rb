class ListingPolicy < ApplicationPolicy
  
  class Scope < Scope
    def resolve
      if @user
        @scope.open.or(@scope.where(user_id: @user.id))
      else
        @scope.open
      end
    end
  end

  def initialize(user, listing)
    @listing = listing
    @user = user
  end

  def show?
    @listing.open? || owned?
  end

  def new?
    true
  end

  def close?
    (@listing.open? && owned?)
  end

  def open?
    (! @listing.open? ) && owned?
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

  def signed_in?
    ! @user.nil?
  end

end
