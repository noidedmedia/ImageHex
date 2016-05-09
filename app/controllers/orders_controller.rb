class OrdersController < ApplicationController
  include Pundit
  before_action :ensure_user
  before_action :load_listing

  def index
    @orders = @listing.orders  
  end

  def new
    @order = Order.new
    authorize @order
  end

  def edit
    @order = @listing.orders.new(user: current_user)
    authorize @order
  end


  protected
  def load_listing
    @listing = Listing.find(params[:listing_id])
  end
end
