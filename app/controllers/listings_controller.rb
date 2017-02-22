class ListingsController < ApplicationController
  include Pundit

  before_action :ensure_user, except: [:index, :show]

  def mine
    @listings = current_user.listings
      .includes(:images)
      .order(created_at: :desc)
      .paginate(page: page, per_page: per_page)
    render 'index'
  end

  def index
    listings = Listing.all
      .with_average_prices
      .open
      .order(created_at: :desc)
      .paginate(page: page, per_page: per_page)
      .includes(:images)
    @listings = ListingsPresenter.new(listings)
  end

  def show
    @listing = Listing.find(params[:id])
    authorize @listing
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
        format.html do 
          render json: @listing.errors,
            status: :unprocessible_entity
        end
      end
    end
  end

  def create
    @listing = Listing.new(listing_params)
    authorize @listing
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

  def open
    @listing = Listing.find(params[:id])
    authorize @listing
    begin
      ListingOpenService.new(@listing).perform
    rescue ListingOpenService::StripelessUserError
      redirect_to authorize_stripe_index,
        alert: "You need to connect to Stripe first."
      return
    end
    redirect_to @listing
  end

  def close
    @listing = Listing.find(params[:id])
    authorize @listing
    @listing.make_closed!
    redirect_to @listing
  end

  protected
  def listing_params
    params.require(:listing)
      .permit(:name,
              :description,
              :base_price,
              :quote_only,
              :nsfw_gore,
              :nsfw_language,
              :nsfw_sexuality,
              :nsfw_nudity,
              image_ids: [],
              options_attributes: [option_attributes],
              categories_attributes: [categories_attributes])
      .merge(user_id: current_user.id)
  end

  def option_attributes
    [:price,
      :_destroy,
      :name,
      :description,
      :id]
  end


  def categories_attributes
    [:price,
      :_destroy,
      :max_count,
      :free_count,
      :name,
      :description,
      :id]
  end

end
