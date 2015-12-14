class CommissionOffer < ActiveRecord::Base
  belongs_to :commission_product
  belongs_to :user
end
