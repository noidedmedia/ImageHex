# frozen_string_literal: true
class CuratorshipsController < ApplicationController
  ##
  # Use pundit for access control
  include Pundit

  ##
  # Only registered users can trouch this controller
  before_action :ensure_user

  ##
  # Make a new curatorship
  # @curatorship:: Curatorship being created.
  def create
    @curatorship = Curatorship.new(curatorship_params)
    authorize @curatorship
    if @curatorship.save
      redirect_to @curatorship.collection
    else
      format.html do
        redirect_to @curatorship.collection,
                    warning: @curatorship.errors.full_messages
      end
    end
  end

  ##
  # Remove a curatorship.
  # @curatorship:: Curatorship being removed.
  def delete
    @curatorship = Curatorship.find(params[:id])
    authorize @curatorship
    @curatorship.delete
  end

  ##
  # Modify a curatorship.
  # Can only be done by admins.
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
