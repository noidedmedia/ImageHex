class CollectionsController < ApplicationController
  before_filter :ensure_user, only: [:subscribe, :new, :create, :edit, :destroy, :update]
  def index
    @user = User.friendly.find(params[:user_id])
    @collections = @user.collections
  end

  def subscribe
    current_user.subscribe! Collection.find(params[:id])
    redirect_to :back

    ## in case our session doesn't have a back
  rescue ActionController::RedirectBackError
    redirect_to root_path
  end

  def show
    @collection = Collection.find(params[:id])
    @images = @collection.images.paginate(page: page, per_page: per_page)
    @curators = @collection.curators
  end

  def new
    @collection = Collection.new
  end

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
  def collection_params
    params.require(:collection)
      .permit(:type, :name, :description)
      .merge(curators: [current_user])
  end
end
