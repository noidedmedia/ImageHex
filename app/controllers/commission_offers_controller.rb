class CommissionOffersController < ApplicationController
  include Pundit
  after_action :verify_authorized
  before_action :ensure_user
  before_action :set_product, only: [:index, :new, :create]
  def index

  end

  def new
    @offer = @product.offers.build
    authorize @offer
  end

  def create

  end

  def update 

  end
  protected
  def commission_offer_params

  end

  def set_product
    @product = CommissionProduct.find(params[:commission_product_id])
  end
end
