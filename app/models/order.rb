class Order < ActiveRecord::Base
  belongs_to :listing

  belongs_to :user

  belongs_to :image,
    required: false

  has_many :order_options,
    class_name: "Order::Option",
    inverse_of: :order

  has_many :options,
    class_name: "Listing::Option",
    through: :order_options

  has_many :references,
    class_name: "Order::Reference",
    inverse_of: :order
  
  has_many :reference_images,
    class_name: "Order::Reference::Image",
    through: :references,
    source: :images

  has_one :conversation

  accepts_nested_attributes_for :references,
    allow_destroy: true

  validates :user, presence: true

  validates :listing, presence: true

  validates :final_price,
    presence: true,
    :if => :accepted?

  validate :not_order_to_self

  validate :order_has_references

  validate :image_is_eligable

  before_validation :calculate_final_price, 
    :if => :final_price_needs_calculation?

  after_save :create_conversation, 
    :if => :needs_conversation_creation

  ##########
  # SCOPES #
  ##########

  def self.to_user(user)
    joins(listing: :user)
      .references(listing: :user)
      .where(listings: {user_id: user})
  end

  def self.unfilled
    where(image_id: nil)
  end

  def self.confirmed
    where(confirmed: true)
  end

  def self.unrejected
    where(rejected: false)
  end

  def self.active
    confirmed.unrejected.unfilled
  end

  ####################
  # INSTANCE METHODS #
  ####################


  def filled?
    ! image.nil?
  end

  def fill(img)
    fail TypeError, "That's not an image" unless img.is_a? Image
    self.class.transaction do 
      update!(image: img,
              filled_at: Time.zone.now)
      Notification.create(user: self.user,
                          kind: :order_filled,
                          subject: self)
    end
  end

  def charge(charge)
    self.class.transaction do 
      update(charge_id: charge["id"],
             charged_at: Time.at(charge["created"]).utc.to_datetime)
      Notification.create(user: self.listing.user,
                          kind: :order_paid,
                          subject: self)
    end
  end

  def accept(params)
    attrs = {
      accepted: true,
      accepted_at: Time.current
    }
    if self.listing.quote_only?
      attrs[:final_price] = params[:quote_price]
    end
    result = true
    begin
      Order.transaction do
        self.update!(attrs)
        notify_acceptance!
      end
    rescue ActiveRecord::RecordInvalid
      result = false
    end
    result
  end

  def confirm
    result = true
    begin
      Order.transaction do 
        update(confirmed: true,
               confirmed_at: Time.current)
        notify_confirmation!
      end
    rescue ActiveRecord::RecordInvalid
      result = false
    end
    result
  end

  def reject
    result = true
    begin
      Order.transaction do
        update!(rejected: true,
                rejected_at: Time.current)
        notify_rejection!
      end
    rescue ActiveRecord::RecordInvalid
      result = false
    end
    result
  end

  def references_by_category
    h = Hash.new{|hash, key| hash[key] = []}
    self.references.each do |ref|
      h[ref.category] << ref
    end
    h
  end

  def calculated_final_price
    raise "Cannot calculate quote price" if self.listing.quote_only?
    self.listing.base_price + options_price + references_price
  end

  private

  def notify_acceptance!
    Notification.create!(kind: :order_accepted,
                         user: self.user,
                         subject: self)
  end

  def notify_confirmation!
    Notification.create!(kind: :order_confirmed,
                         user: self.listing.user,
                         subject: self)
  end

  def notify_rejection!
    Notification.create!(kind: :order_rejected,
                         user: self.user,
                         subject: self)
  end

  def needs_conversation_creation
    self.conversation.nil? && self.confirmed?
  end

  def create_conversation
    Conversation.create(name: "Order Conversation",
                        users: [self.user, self.listing.user],
                        order: self)
  end

  def image_is_eligable
    return unless self.image
    unless self.image.created_at > self.charged_at
      errors.add(:image,
                 "was created before this order was charged")
    end
  end

  def order_has_references
    if references.blank?
      errors.add(:references, "need at least 1")
    end
  end

  def not_order_to_self
    unless user != listing.user
      errors.add(:user, "created this listing")
    end
  end

  def calculate_final_price
    return unless final_price_needs_calculation?
    self.final_price = calculated_final_price
  end

  def final_price_needs_calculation?
    (self.confirmed? &&
     ! self.listing.quote_only &&
     self.final_price.nil?)
  end

  def options_price
    (options.map(&:price).reduce(:+) || 0)
  end

  def references_price
    (references_by_category.map do |val|
      category, refs = val
      paid_count = (refs.count - category.free_count)
      if paid_count > 0 then
        paid_count * category.price
      else
        0
      end
    end.reduce(:+) || 0)
  end
end
