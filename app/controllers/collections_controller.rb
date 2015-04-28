##
# A controller for actions relating to collections
class CollectionsController < ApplicationController
  before_filter :ensure_user, only: [:subscribe, :new, :create, :edit, :destroy, :update, :unsubscribe]
  ##
  # Unsubscribe from a collection
  # Member action
  def unsubscribe
    Subscription.where(collection_id: params[:id],
                       user_id: current_user.id)
      .first
      .try(:destroy)
    redirect_to Collection.find(params[:id])
  end
  ##
  # Add the image with id in params[:image_id] to the collection with id in
  # params[:id].
  # Requires log in. 
  # If the user does not curate the collection, it puts a relevant error
  # message in flash[:error] and redirects to the image.
  # On success, it simply redirects to the image.
  def add
    c = Collection.find(params[:id])
    ##
    # If the current usn't doesn't curate this colletion, they cannot
    # add images to it
    if ! c.curated?(current_user)
      flash[:error] = "You cannot add images to a collection you do not own."
      redirect_to Image.find(params[:image_id]) and return
    end
    image = Image.find(params[:image_id])
    c.images << image
    redirect_to image
  end
  ##
  # Remove the image with id in params[:image_id] from the collection in
  # params[:id].
  # Requires login.
  # Only does anything if current_user has permissions to remove images
  # from the collection.
  # Always returns a JSON true or false, indicating success.
  # TODO: refactor this, make it less bad.
  def remove
    col = Collection.find(params[:id])
    image = Image.find(params[:image_id])
    worked = false
    if col && col.images.include?(image)
      col.images.delete(image)
      worked = true
    end
    render json: worked
  end
  ##
  # Show all the collections on the user in params[:user_id].
  # Sets the following variables:
  # @user:: The user who owns the collections
  # @collections:: The collections owned by the user.
  def index
    @user = User.friendly.find(params[:user_id])
    @collections = @user.collections
  end

  ##
  # Subscribes current_user to the collection with id in params[:id]
  # Requires login.
  # Redirects back afterwards.
  # If "redirect back" means nothing (IE, hitting the back button is impossible
  # since the user's first page in the session was this page), it redirects
  # to the homepage.
  def subscribe
    current_user.subscribe! Collection.find(params[:id])
    redirect_to :back

    ## in case our session doesn't have a back
  rescue ActionController::RedirectBackError
    redirect_to root_path
  end

  ##
  # Show a collection, including all info and images within.
  # Sets the following varaibles:
  # @collection:: The collection being viewed
  # @curators:: the users who curate the collection
  # @images:: Images in the collection
  def show
    @collection = Collection.find(params[:id])
    @images = @collection.images.paginate(page: page, per_page: per_page)
    @curators = @collection.curators
  end

  ##
  # Displays a page to create a new collection.
  # Requires login.
  # Sets the following variables:
  # @collection:: A new collection object for form-building.
  def new
    @collection = Collection.new
  end

  ##
  # POST to create a new collection
  # Redirects to the new action with errors in flash[:warning] on failure,
  # and to the created collection on success.
  def create
    c = nil
    # We create 2 different types in this view. So we have to build
    # models in that way
    case collection_params[:type]
    when "Subjective"
      c = Subjective.new(collection_params)
    end
    unless c
      flash[:warning] = "Collection type not specified or not applicable."
      redirect_to action: "new" and return
    end
    if c.save
      redirect_to collection_path(id: c.id) and return
    else
      flash[:warning] = c.errors.full_messages.join(", ")
      redirect_to action: "new"
    end
  end

  protected
  ##
  # Parameters needed to create the collection.
  # type:: What type of collection it is. Currently, only "Subjective" is
  #        user-creatable
  # name:: What to name this collection
  # description:: A short bit of info describing this collection.
  def collection_params
    params.require(:collection)
      .permit(:type, :name, :description)
      .merge(curators: [current_user])
  end
end
