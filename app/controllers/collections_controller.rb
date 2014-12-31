class CollectionsController < ApplicationController
  before_filter :ensure_user, only: [:new, :create, :edit, :destroy, :update]
  def index
    @user = User.find(params[:user_id])
    @collections = @user.collections
  end

  def show
    @collection = Collection.find(params[:id])
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
    when "Chronological"
      c = Chronological.new(collection_params)
    end
    unless c
      flash[:error] = "Collection type not specified or not applicable."
      redirect_to :new
    end
    if c.save
      redirect_to c
    else
      flash[:error] = c.errors.full_messages
      redirect_to :new
    end
  end

  protected
  def collection_params
    params.require(:collection)
      .permit(:type, :title, :description)
      .merge(user_id: current_user.id)
  end
end
