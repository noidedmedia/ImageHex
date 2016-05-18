class Listing < ActiveRecord::Base
  belongs_to :user, required: true

  has_many :categories,
    class_name: 'Listing::Category',
    inverse_of: :listing,
    autosave: true

  accepts_nested_attributes_for :categories

  has_many :options, inverse_of: :listing,
    autosave: true

  accepts_nested_attributes_for :options

  has_many :listing_images
  has_many :images, through: :listing_images

  has_many :orders

  validate :validate_has_categories

  private
  def validate_has_categories
    
  end
end
