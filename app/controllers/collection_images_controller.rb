##
# This controller is for adding images to a collection (or removing them).
#
# It only contains the POST and DELETE actions, since that is all that really
# makes sense on this controller.
class CollectionImagesController < ApplicationController
  ##
  # Use pundit for permissions
  include Pundit

  ##
  # Make a new collection_image
  # This adds an image to a collection
  # Use collection_image_params
  def create
    c = CollectionImage.create(collection_image_params)
    authorize c
    if c.save
      respond_to do |format|
        format.html { redirect_to(request.referrer || root_path) }
        format.json { render json: { successful: true } }
      end
    else
      flash[:warning] = c.errors.full_messages
      redirect_to(request.referrer || root_path)
    end
  end

  ##
  # Remove an image from a collection
  def destroy
    img = Image.find(params[:id])
    col = Collection.find(params[:collection_id])
    c = CollectionImage.where(image: img,
                              collection: col).first
    unless c
      respond_to do |format|
        format.json { render json: { success: false }, status: :not_found }
        format.html { redirect_to col }
      end
      return
    end
    authorize c
    c.destroy!
    respond_to do |format|
      format.json { render json: { success: true } }
      format.html { redirect_to col }
    end
  end

  protected

  ##
  # Paramters, of the format:
  #    collection_image:
  #        image_id: $image_id
  #
  # The collection_id is automatically taken from the URL.
  def collection_image_params
    params.require(:collection_image)
      .permit(:image_id)
      .merge(user_id: current_user.id,
             collection_id: params[:collection_id])
  end
end
