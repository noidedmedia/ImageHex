class ProductExampleImage < ActiveRecord::Base
  belongs_to :commission_product
  belongs_to :image
end
