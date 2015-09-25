class CuratorshipsController < ApplicationController
  ##
  # Use pundit for access control
  include Pundit

  ##
  # Only registered users can trouch this controller
  before_filter :ensure_user

  ##
  # Make a new curatorship
  def create
    @curatorship = Curatorship.new(curatorship_params)
    authorize @curatorship
    if @curatorship.save
      redirect_to @curatorship.collection
    else
      flash[:warning] = @curatorship.errors.full_messages
      redirect_to @curatorship.collection
    end
  end

  ##
  # Remove a curatorship
  def delete
    @curatorship = Curatorship.find(params[:id])
    authorize @curatorship
    @curatorship.delete
  end

  ## 
  # Modify a curatorship
  # Can only be done by admins
  #
  # Common use case is promoting or demoting a user
  def update
    @curatorship = Curatorship.find(params[:id])
    authorize @curatorship
    if @curatorship.update(curatorship_params)
      redirect_to @curatorship.collection
    else
      flash[:warning] = @curatorship.errors.full_messages
      redirect_to @curatorship
    end
  end

  protected

  ##
  # Paramters for the curatorship
  # Of the form:
  #     curatorship:
  #         user_id OR user_name
  #         level
  def curatorship_params
    params.require(:curatorship)
    .permit(:user_id,
            :user_name,
            :level)
    .merge(collection_id: params[:collection_id])
  end
end
