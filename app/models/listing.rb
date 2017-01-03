class Listing < ActiveRecord::Base

  scope :confirmed, -> { where(confirmed: true) }

  scope :open, -> { where(open: true) }

  belongs_to :user, required: true

  has_many :listing_images,
    class_name: 'Listing::Image',
    inverse_of: :listing

  has_many :images, 
    through: :listing_images,
    class_name: "::Image"

  has_many :orders

  def completely_safe?
    ! (nsfw_gore? || nsfw_nudity? || nsfw_language? || nsfw_sexuality?)
  end


  def make_open!
    update(open: true)
  end

  def make_closed!
    update(open: false)
  end

  def closed?
    ! open?
  end
end

require_dependency 'listing/image'
