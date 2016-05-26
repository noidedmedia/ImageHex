class Listing::Category < ActiveRecord::Base
  belongs_to :listing

  validates :description, presence: true
  validates :name, presence: true
end
