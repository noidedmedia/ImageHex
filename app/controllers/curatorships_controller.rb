class CuratorshipsController < ApplicationController
  include Pundit
  before_filter :ensure_user
  def create
    @curatorship = Curatorship.new(curatorship_params)
    authorize @curatorship
    if @curatorship.save
      redirect_to @curatorship.collection
    else
      flash[:warning] = @curatorship.errors.full_messages
      redirect_to @curatorship
    end
  end
  def delete
    @curatorship = Curatorship.find(params[:id])
    authorize @curatorship
    @curatorship.delete
  end
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

  def curatorship_params
    params.require(:curatorship).permit(:user_id,
                                        :collection_id,
                                        :curatorship_id)
  end
end
