class CommissionProduct < ActiveRecord::Base
  belongs_to :user
  has_many :offers, class_name: "CommissionOffer"

  validates :base_price, numericality: {greater_than: 300}
  validates :subject_price,
    presence: true,
    numericality: {greater_than: 0},
    :if => :offer_subjects?

  validates :background_price,
    presence: true,
    numericality: {greater_than: 0},
    :if => :charge_for_background?

  validates :user, presence: true

  validates :maximum_subjects,
    numericality: {greater_than: 1},
    allow_nil: true,
    :unless => :offer_subjects?

  def allow_further_subjects?
    offer_subjects?
  end

  def includes_subjects?
    included_subjects > 0
  end

  def allow_background?
    include_background? || offer_background?
  end
  
  ##
  # You have to pay for backgrounds if they are allowed
  # but not free
  def charge_for_background?
    allow_background? && ! include_background?
  end
end
