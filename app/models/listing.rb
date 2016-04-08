class Listing < ActiveRecord::Base
  belongs_to :user
  has_many :options, inverse_of: :listing
  accepts_nested_attributes_for :options,
    allow_destroy: :true

end
