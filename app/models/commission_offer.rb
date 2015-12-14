class CommissionOffer < ActiveRecord::Base
  belongs_to :commission_product
  belongs_to :user
  has_many :subjects, class_name: "CommissionSubject"
  has_many :backgrounds, class_name: "CommissionBackground"
  accepts_nested_attributes_for :subjects
  accepts_nested_attributes_for :backgrounds

  validates :user, presence: true
  validates :commission_product, presence: true

  validate :has_acceptable_subject_count
  before_save :calculate_price
  protected
  def has_acceptable_subject_count
    return unless commission_product
    if (s = commission_product.try(:maximum_subjects)) && subjects.size > s
      errors.add(:subjects, "have more than this product's maximum")
    end
    unless commission_product.allow_further_subjects?
      if subjects.size > commission_product.included_subjects
        errors.add(:subject, "have too many")
      end
    end
  end

  def calculate_price
    p = commission_product
    i = p.base_price
    subject_charge_count = subjects.size - p.included_subjects
    i += p.subject_price * subject_charge_count if subject_charge_count > 0
    if backgrounds.size > 0 && ! p.includes_background?
      i += p.background_price
    end
    self.total_price = i 
  end
end
