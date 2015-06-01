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
  # Display an error when teh user is unauthorized
  rescue_from Pundit::NotAuthorizedError, with: :unauthorized
  ##
  # Make a new collection_image
  # This adds an image to a collection
  # Use collection_image_params
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

  ##
  # Remove an image from a collection
  def destroy
    img = Image.find(params[:id])
    col = Collection.find(params[:collection_id])
    c = CollectionImage.where(image: img,
                              collection: col).first
    redirect_to Collection.find(params[:collection_id]) and return unless c
    authorize c
    c.destroy

    redirect_to col
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
