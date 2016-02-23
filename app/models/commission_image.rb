# frozen_string_literal: true
class CommissionImage < ActiveRecord::Base
  belongs_to :image
  belongs_to :commission_offer
  validates :image, presence: true
  validates :commission_offer, presence: true
end
