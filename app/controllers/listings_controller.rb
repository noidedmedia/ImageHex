class ListingsController < ApplicationController
  include Pundit

  before_action :ensure_user, except: [:index, :show]

  def mine
    @listings = current_user.listings
      .order(created_at: :desc)
    render 'index'
  end

  def index
    @listings = Listing.all
      .confirmed
      .open
      .order(created_at: :desc)
      .paginate(page: page, per_page: per_page)
  end

  def confirm
    begin
      @listing = Listing.find(params[:id])
      authorize @listing
      @listing.update(confirmed: true, open: true)
      redirect_to @listing
    rescue Pundit::NotAuthorizedError
      redirect_to "/stripe/authorize"
    end
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

  def open
    @listing = Listing.find(params[:id])
    authorize @listing
    @listing.make_open!
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
              image_ids: [],
              options_attributes: [option_attributes],
              categories_attributes: [categories_attributes])
      .merge(user_id: current_user.id)
  end

  def option_attributes
    [:price,
      :name,
      :description,
      :id]
  end


  def categories_attributes
    [:price,
      :max_count,
      :free_count,
      :name,
      :description,
      :id]
  end

end
