class CommissionProduct < ActiveRecord::Base
  belongs_to :user
  validates :base_price, numericality: {minmum: 350}
end
