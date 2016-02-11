class Dispute < ActiveRecord::Base
  belongs_to :commission_offer

  validates :commission_offer, presence: true

  scope :unresolved, ->{ where(resolved: false) }

end
