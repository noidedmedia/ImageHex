# frozen_string_literal: true
class ListingExampleImage < ActiveRecord::Base
  belongs_to :listing
  belongs_to :image
end
