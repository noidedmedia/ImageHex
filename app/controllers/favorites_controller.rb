class FavoritesController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @images = @user.favorites.images.paginate(page: page, per_page: per_page)
  end
end
