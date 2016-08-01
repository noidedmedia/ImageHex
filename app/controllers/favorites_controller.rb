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

  def destroy
    @favorite = Favorite.find(params[:id])
    @image = @favorite.image
    authorize @favorite
    respond_to do |format|
      if @favorite.destroy
        format.html{ redirect_to @image, notice: "Unfavorited" }
        format.json{ render json: {success: true} }
      else
        format.html{ redirect_to @image, warning: "Could not unfavorite" }
        format.json{ render json: {success: false} }
      end
    end
  end

  protected

  def favorite_params
    params.require(:favorite)
      .permit(:image_id)
      .merge(user_id: current_user.id)
  end
end
