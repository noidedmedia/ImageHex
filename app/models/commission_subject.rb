class CommissionSubject < ActiveRecord::Base
  belongs_to :commission_offer
  has_many :commission_subject_tags
  has_many :tags, through: :commission_subject_tags
  has_many :references, class_name: "SubjectReference",
                        inverse_of: :commission_subject
  validates :commission_offer, presence: true
  validate :has_acceptable_reference_number
  accepts_nested_attributes_for :references,
    allow_destroy: true
  attr_accessor :tag_ids
  before_validation :build_tag_ids

  def build_tag_ids
    self.tags = Tag.where(id: tag_ids) if tag_ids && tag_ids.is_a?(Array)
  end

  def has_acceptable_reference_number
    if references.length > 5
      errors.add(:subject_references, "must have less than 5")
    end
  end
end
