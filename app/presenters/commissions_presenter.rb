class CommissionsPresenter
  def initialize(current_user)
    @user = current_user
  end

  def placed_orders
    @placed_orders ||= OrdersPresenter.new(@user.orders)
  end

  def recieved_orders
    @recieved_orders ||= OrdersPresenter.new(Order.to_user(@user).confirmed)
  end

  def listings
    @listings ||= ListingsPresenter.new(@user.listings.includes(:images).to_a)
  end

  class OrdersPresenter
    def initialize(orders)
      @orders = orders
    end

    def completed
      @orders.select{|o| o.image.present?}
    end

    def rejected
      @rejected ||= @orders.select(&:rejected?)
    end

    def active
      @active ||= @orders.select{|o| o.accepted? && o.image_id.nil?}
    end

    def pending
      @pending ||= @orders.select{|o| ! o.accepted? && ! o.rejected?}
    end

    def method_missing(meth, *args)
      @orders.public_send(meth, *args)
    end
  end

  class ListingsPresenter
    def initialize(listings)
      @listings = listings
    end

    def open
      @listings.select(&:open?)
    end


    def unopen
      @listings.reject(&:open?)
    end

    def draft
      @listings.reject(&:confirmed?)
    end

    def types
      %w(open unopen draft)
    end
  end
end
