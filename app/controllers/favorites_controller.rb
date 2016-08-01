class FavoritesController < ApplicationController
  before_action :ensure_user

  include Pundit
  def create
    @favorite = Favorite.new(favorite_params)
    authorize @favorite
    respond_to do |format|
      if @favorite.save
        format.html { redirect_to @favorite.image, notice: "favorited" }
        format.json { render 'show' }
      else
        format.html do 
          redirect_to @favorite.image, warning: "Could not favorite"
        end
        format.json { render json: @favorite.errors, status: 401 }
      end
    end
  end

  protected

  def favorite_params
    params.require(:favorite)
      .permit(:image_id)
  end
end
