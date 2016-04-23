class ListingImage < ActiveRecord::Base
  belongs_to :image
  belongs_to :listing
  validates :image, presence: true
  validates :listing, presence: true
  validate :share_user

  protected
  def share_user
    unless image.creators.include? listing.user 
      errors.add(:image, "was not created by this user")
    end
  end
end
