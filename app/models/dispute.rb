class Dispute < ApplicationRecord
  belongs_to :order

  validates :description, presence: true
  validates :order, presence: true

  def self.unresolved
    where(resolved: false)
  end
end
