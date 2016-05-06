class ListingsController < ApplicationController
  include Pundit
  before_action :ensure_user, except: [:index, :show]

  def index
    @listings = Listing.all.order(created_at: :desc)
      .includes(:images)
      .paginate(page: page, per_page: per_page)
  end

  def show
    @listing = Listing.find(params[:id])
  end

  def new
    @listing = Listing.new
  end

  def edit
    @listing = Listing.find(params[:id])
    authorize @listing
  end

  def update
    @listing = Listing.find(params[:id])
    authorize @listing
    respond_to do |format|
      if @listing.update(listing_params)
        format.html { redirect_to @listing }
        format.json { render 'show' }
      else
        format.html { render 'edit', errors: @listing.errors }
        format.html { render json: @listing.errors,
          status: :unprocessible_entity }
      end
    end
  end

  def create
    @listing = Listing.new(listing_params)
    respond_to do |format|
      if @listing.save
        format.json { render 'show' }
        format.html { redirect_to @listing }
      else
        format.html { render 'new' }
        format.json { render json: @listing.errors, status: 422 }
      end
    end
  end

  def listing_params
    params.require(:listing)
      .permit(:name,
              :description,
              :base_price,
              :quote_only,
              options_attributes: [option_attributes])
      .merge(user_id: current_user.id)
  end

  def option_attributes
    [:price,
      :reference_category,
      :max_allowed,
      :name,
      :description,
      :free_count]
  end
end
