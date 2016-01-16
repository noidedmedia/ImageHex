class CommissionBackground < ActiveRecord::Base
  belongs_to :commission_offer,
             inverse_of: :background

  has_many :references, class_name: "BackgroundReference"
  accepts_nested_attributes_for :references,
                                allow_destroy: true

  validate :has_acceptable_references

  protected

  def has_acceptable_references
    errors.add(:references, "have too many") unless references.length < 11
  end
end
