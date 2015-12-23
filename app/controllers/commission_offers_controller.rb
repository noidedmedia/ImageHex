class CommissionOffersController < ApplicationController
  include Pundit
  after_action :verify_authorized
  before_action :ensure_user
  before_action :set_product, only: [:index, :new, :create]
  def index

  end

  def confirm
    @offer = CommissionOffer.find(params[:id])
    authorize @offer
    respond_to do |format|
      if @offer.confirm!
        format.html {redirect_to @offer, notice: "confirmed!"}
        format.json {render json: true}
      else
        format.html {redirect_to @offer, notice: "Something went wrong"}
        format.json {render json: false}
      end
    end
  end

  def accept
    @offer = CommissionOffer.find(params[:id])
    authorize @offer
    respond_to do |format|
      if @offer.accept!
        format.html {redirect_to @offer, notice: "Accepted!"}
        format.json {render json: true}
      else
        format.html {redirect_to @offer, notice: "Something went wrong"}
        format.json {render json: true}
      end
    end
  end

  def show
    @offer = CommissionOffer.find(params[:id])
    authorize @offer
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
      .permit(:description,
        subjects_attributes: [:description,
              {tag_ids: []},
              {references_attributes: [:file]}],
        backgrounds_attributes: [:description, {references_attributes: [:file]}])
      .merge(user_id: current_user.id)
  end

  def set_product
    @product = CommissionProduct.find(params[:commission_product_id])
  end
end
