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
    @offer = @product.offers.build(commission_offer_params)
    authorize @offer
    respond_to do |format|
      if @offer.save
        format.html {redirect_to @offer}
        format.json {render 'show'}
      else
        format.html {render 'new'}
        format.json {render json: @offer.errors, status: :unprocessible_entity}
      end
    end
  end

  def update 

  end
  protected
  def commission_offer_params
    params.require(:commission_offer)
      .permit(subjects_attributes: [:description,
              {tag_ids: []},
              {references_attributes: [:file]}])
  end

  def set_product
    @product = CommissionProduct.find(params[:commission_product_id])
  end
end
