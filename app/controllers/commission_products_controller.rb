class CommissionProductsController < ApplicationController
  include Pundit
  after_action :verify_authorized
  before_action :ensure_user, except: [:index, :show]

  def new
    @product = CommissionProduct.new
    authorize(@product)
  end

  def create
    @product = CommissionProduct.new(commission_product_params)
    authorize @product
    respond_to do |format|
      if @product.save
        format.html {redirect_to @product}
        format.json {render action: 'show'}
      else
        format.html {render 'new'}
        format.json {render json: @product.errors, status: 422}
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
              :includes_background,
              :maximum_subjects)
  end
end
