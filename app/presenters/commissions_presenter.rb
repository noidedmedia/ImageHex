class CommissionsPresenter
  def initialize(current_user)
    @user = current_user
  end

  def placed
    @placed_orders ||= OrdersPresenter.new(@user.orders)
  end

  def received
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
      @pending ||= @orders.select do |o| 
        ! o.accepted? && ! o.rejected? && o.confirmed?
      end
    end

    def draft
      @draft ||= @orders.select{|o| ! o.confirmed? }
    end

    def unpaid
      @unpaid ||= @orders.select{|o| o.accepted? && o.charge_id.nil?}
    end

    def method_missing(meth, *args)
      @orders.public_send(meth, *args)
    end

    def types(for_customer = true)
      if for_customer
        %w(completed active pending rejected unpaid draft)
      else
        %(completed active pending unpaid)
      end
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

    def method_missing(meth, *args, **kwargs)
      @listings.public_send(meth, *args, **kwargs)
    end
  end
end
