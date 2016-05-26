class Listing < ActiveRecord::Base
  belongs_to :user, required: true

  has_many :categories,
    class_name: 'Listing::Category',
    inverse_of: :listing,
    autosave: true

  accepts_nested_attributes_for :categories

  has_many :options, 
    class_name: 'Listing::Option',
    inverse_of: :listing,
    autosave: true

  accepts_nested_attributes_for :options

  has_many :listing_images,
    class_name: 'Listing::Image',
    inverse_of: :listing

  has_many :images, through: :listing_images

  accepts_nested_attributes_for :listing_images

  has_many :orders

  validate :listing_has_categories

  private
  def listing_has_categories
    if categories.blank?
      errors.add(:categories, "need at least one")
    end
  end
end

require_dependency 'listing/image'
