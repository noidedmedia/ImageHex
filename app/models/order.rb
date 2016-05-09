class Order < ActiveRecord::Base
  belongs_to :listing
  belongs_to :user
  has_many :aspects

  validates :user, presence: true
  validates :listing, presence: true

  validate :not_order_to_self
  accepts_nested_attributes_for :aspects

  private

  def not_order_to_self
    unless user != listing.user
      errors.add(:user, "created this listing")
    end
  end

end
