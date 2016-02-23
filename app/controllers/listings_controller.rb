# frozen_string_literal: true
class ListingsController < ApplicationController
  include Pundit
  after_action :verify_authorized, except: [:index, :show, :search]
  before_action :ensure_user, except: [:index, :show]

  def search
    @products = Listing.all
      .confirmed
      .joins(:example_images)
      .paginate(page: page, per_page: per_page)
      .preload(:example_images)
      .merge(Image.for_content(content_pref))
      .for_search(params)
      .uniq
  end

  def index
    @products = Listing.all
      .confirmed
      .joins(:example_images)
      .preload(:example_images)
      .merge(Image.for_content(content_pref))
      .paginate(page: page, per_page: per_page)
      .uniq
  end

  def new
    @product = Listing.new
    authorize(@product)
  end

  def confirm
    @product = Listing.find(params[:id])
    authorize @product
    @product.update(confirmed: true)
    redirect_to @product
  rescue Pundit::NotAuthorizedError
    redirect_to "/stripe/authorize",
                warning: "Confirm your stripe first"
  end

  def show
    @product = Listing.find(params[:id])
    @example_images = @product.example_images
      .for_content(content_pref)
  end

  def create
    @product = Listing.new(listing_params)
    authorize @product
    respond_to do |format|
      if @product.save
        format.html { redirect_to @product }
        format.json { render action: 'show' }
      else
        format.html { render 'new' }
        format.json { render json: @product.errors, status: 422 }
      end
    end
  end

  def edit
    @product = Listing.find(params[:id])
    authorize @product
  end

  def update
    @product = Listing.find(params[:id])
    authorize @product
    respond_to do |format|
      if @product.update(listing_params)
        format.html { redirect_to @product }
        format.json { render action: "show" }
      else
        format.html { render "edit" }
        format.json { render json: @product.errors, status: 422 }
      end
    end
  end

  protected

  def listing_params
    params.require(:listing)
      .permit(:name,
              :description,
              :base_price,
              :included_subjects,
              :subject_price,
              :include_background,
              :background_price,
              :offer_background,
              :offer_subjects,
              :maximum_subjects,
              :weeks_to_completion,
              example_image_ids: [])
      .merge(user_id: current_user.id)
  end
end
