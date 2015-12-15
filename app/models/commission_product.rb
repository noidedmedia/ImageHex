class CommissionProduct < ActiveRecord::Base
  belongs_to :user
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
    allow_nil: true

  def allow_further_subjects?
    subject_price > 0
  end

  def includes_subjects?
    included_subjects > 0
  end

  def allow_background?
    includes_background? || offer_background?
  end
  
  ##
  # You have to pay for backgrounds if they are allowed
  # but not free
  def charge_for_background?
    allow_background? && ! includes_background?
  end
end
