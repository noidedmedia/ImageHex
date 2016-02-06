class CommissionProductsController < ApplicationController
  include Pundit
  after_action :verify_authorized, except: [:index, :show, :search]
  before_action :ensure_user, except: [:index, :show]

  def search
    @products = CommissionProduct.all
      .joins(:example_images)
      .paginate(page: page, per_page: per_page)
      .preload(:example_images)
      .merge(Image.for_content(content_pref))
      .for_search(params)
      .uniq
  end

  def index
    @products = CommissionProduct.all
      .joins(:example_images)
      .preload(:example_images)
      .merge(Image.for_content(content_pref))
      .paginate(page: page, per_page: per_page)
      .uniq
  end

  def new
    @product = CommissionProduct.new
    authorize(@product)
  end

  def show
    @product = CommissionProduct.find(params[:id])
    @example_images = @product.example_images
      .for_content(content_pref)
  end

  def create
    @product = CommissionProduct.new(commission_product_params)
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
    @product = CommissionProduct.find(params[:id])
    authorize @product
  end

  def update
    @product = CommissionProduct.find(params[:id])
    authorize @product
    respond_to do |format|
      if @product.update(commission_product_params)
        format.html { redirect_to @product }
        format.json { render action: "show" }
      else
        format.html { render "edit" }
        format.json { render json: @product.errors, status: 422 }
      end
    end
  end

  protected

  def commission_product_params
    params.require(:commission_product)
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
