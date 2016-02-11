class Dispute < ActiveRecord::Base
  belongs_to :user
  belongs_to :commission_offer
  belongs_to :commission_product

  validates :user, presence: true
  validates :commission_offer, presence: true
  validates :commission_product, presence: true
end
