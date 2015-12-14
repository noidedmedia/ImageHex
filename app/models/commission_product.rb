class CommissionProduct < ActiveRecord::Base
  belongs_to :user
  validates :base_price, numericality: {greater_than: 300}
  validates :subject_price,
    presence: true,
    numericality: {greater_than: 0},
    :unless => :includes_subjects?
  validates :user, presence: true

  def allow_further_subjects?
    subject_price > 0
  end

  def includes_subjects?
    included_subjects > 0
  end

end
