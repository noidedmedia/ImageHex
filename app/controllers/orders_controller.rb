class OrdersController < ApplicationController
  include Pundit
  before_action :ensure_user
  before_action :load_listing
  def index
    @orders = @listing.orders  
  end

  protected
  def load_listing
    @listing = Listing.find(params[:listing_id])
  end
end
