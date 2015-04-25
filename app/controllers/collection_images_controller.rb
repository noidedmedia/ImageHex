##
# This controller is for adding images to a collection (or removing them).
#
# It only contains the POST and DELETE actions, since that is all that really
# makes sense on this controller. 
class CollectionImagesController < ApplicationController
  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :unauthorized
  def create
    c = CollectionImage.create(collection_image_params)
    authorize c
    if c.save
      respond_to do |format|
        format.html{redirect_to(request.referrer || root_path)}
        format.json{render json: {successful: true}}
      end
    else
      flash[:warning] = c.errors.full_messages
      redirect_to(request.referrer || root_path)
    end
  end

  def unauthorized
    flash[:error] = "You are not authorized to do that"
    redirect_to(request.referrer || root_path)
  end

  def destroy
    c = CollectionImage.where(image_id: params[:id],
                              collection_id: params[:id])
    authorize c
    c.delete
  end

  protected
  def collection_image_params
    params.require(:collection_image)
      .permit(:image_id)
      .merge(user_id: current_user.id,
             collection_id: params[:collection_id])
  end
end
