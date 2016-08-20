class Listing < ActiveRecord::Base

  scope :confirmed, -> { where(confirmed: true) }

  scope :open, -> { where(open: true) }


  belongs_to :user, required: true

  has_many :categories,
    class_name: 'Listing::Category',
    inverse_of: :listing,
    autosave: true

  accepts_nested_attributes_for :categories,
    allow_destroy: true

  has_many :options, 
    class_name: 'Listing::Option',
    inverse_of: :listing,
    autosave: true

  accepts_nested_attributes_for :options,
    allow_destroy: true

  has_many :listing_images,
    class_name: 'Listing::Image',
    inverse_of: :listing

  has_many :images, 
    through: :listing_images,
    class_name: "::Image"

  has_many :orders

  validates :base_price, presence: true,
    numericality: { only_integer: true, greater_than_or_equal_to: 0 },
    unless: :quote_only?


  validate :listing_has_categories

  def make_open!
    update(open: true)
  end

  def make_closed!
    update(open: false)
  end

  def closed?
    ! open?
  end

  private

  def listing_has_categories
    if categories.blank?
      errors.add(:categories, "need at least one")
    end
  end
end

require_dependency 'listing/image'
