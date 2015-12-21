class CommissionBackground < ActiveRecord::Base
  belongs_to :commission_offer
  has_many :references, class_name: "BackgroundReference"
  accepts_nested_attributes_for :references

  validate :has_acceptable_references

  protected
  def has_acceptable_references
    unless references.length < 11
      errors.add(:references, "have too many")
    end
  end

end
