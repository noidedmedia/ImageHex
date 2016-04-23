class Listing < ActiveRecord::Base
  belongs_to :user, required: true
  has_many :options, inverse_of: :listing
  has_many :listing_images
  has_many :images, through: :listing_images
  accepts_nested_attributes_for :options

end
