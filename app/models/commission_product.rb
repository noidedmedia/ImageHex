class CommissionProduct < ActiveRecord::Base
  belongs_to :user
  validates :base_price, numericality: {greater_than: 300}
end
