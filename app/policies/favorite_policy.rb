class FavoritePolicy < ApplicationPolicy
  def initialize(user, favorite)
    @user = user
    @favorite = favorite
  end

  def create?
    true
  end

  def destroy?
    owned?
  end

  protected
  def owned?
    @favorite.user == @user
  end
end
