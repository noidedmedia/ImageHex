##
# A controller for actions relating to collections
class CollectionsController < ApplicationController
  before_filter :ensure_user, except: [:index, :show]

  include Pundit
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

  def mine
    @collections = if t = params[:inspect_image]
                     img = Image.find(t)
                     current_user.collections.with_image_inclusion(img)
                   else
                     current_user.collections
                   end
    render 'index'
  end

  def index
    @collections = find_index_collections
      .subjective
      .paginate(page: page, per_page: per_page)
      .includes(:images)
    # FIXME: This is a hack.
    @content = content_pref
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
    @images = @collection.images
    .paginate(page: page, per_page: per_page)
    .for_content(content_pref)
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
      flash[:warning] = I18n.t("notices.collection_type_not_specified_or_not_applicable")
      redirect_to action: "new" and return
    end
    respond_to do |format|
      if c.save
        format.html { redirect_to collection_path(id: c.id), notice: I18n.t("notices.collection_created_successfully") }
      else
        format.html { redirect_to new_collection_path, warning: c.errors.full_messages.join(", ") }
      end
    end
  end

  def edit
    @collection = Collection.find(params[:id])
  end

  def update
    @collection = Collection.find(params[:id])
    authorize @collection
    respond_to do |format|
      if @collection.update(collection_params)
        format.html { redirect_to @collection }
        format.json { render :show }
      else
        format.html { render :edit, status: :unproccessible_entity }
        format.json { render @collection.errors, status: :unprocessible_entity }
      end
    end
  end

  def destroy
    @collection = Collection.find(params[:id])
    authorize @collection
    @collection.destroy
    redirect_to root_path
  end

  protected

  def find_index_collections
    case params['order']
    when "popular"
      Collection.by_popularity
    else
      Collection.all.order(created_at: :desc)
    end
  end

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
