class CommissionProduct < ActiveRecord::Base
  belongs_to :user
  has_many :offers, class_name: "CommissionOffer"

  has_many :product_example_images,
           inverse_of: :commission_product

  has_many :example_images,
           through: :product_example_images,
           class_name: "Image",
           source: :image

  validates :base_price, numericality: { greater_than: 300 }

  validates :subject_price,
            presence: true,
            numericality: { greater_than: 0 },
            if: :offer_subjects?

  validates :background_price,
            presence: true,
            numericality: { greater_than: 0 },
            if: :charge_for_background?

  validates :user, presence: true

  validates :weeks_to_completion,
            presence: true,
            numericality: { greater_than: 0, less_than: 52 }

  validates :maximum_subjects,
            numericality: { greater_than: 1 },
            allow_nil: true,
            unless: :offer_subjects?

  validate :example_images_created_by_user

  scope :allows_background, lambda {
    where(offer_background: true)
  }
  def self.for_search(params)
    c = self
    c = c.allows_background if params["has_background"].to_s == "true"
    c
  end

  ##
  # Small hack to make example images easier
  def example_image_ids
    example_images.pluck(:id)
  end

  def example_image_ids=(ar)
    raise ArgumentError.new("must be passed an array") unless ar.is_a? Array
    self.example_images = Image.where(id: ar)
  end

  def allow_further_subjects?
    offer_subjects?
  end

  def includes_subjects?
    included_subjects > 0
  end

  def allow_background?
    include_background? || offer_background?
  end

  ##
  # You have to pay for backgrounds if they are allowed
  # but not free
  def charge_for_background?
    allow_background? && !include_background?
  end

  ##
  # TODO: refactor this so it's faster
  def example_images_created_by_user
    user = self.user
    unless example_images.all? { |i| i.created_by?(user) }
      errors.add(:example_images, "must be created by you")
    end
  end
end
