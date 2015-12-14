class CommissionSubject < ActiveRecord::Base
  belongs_to :commission_offer
  has_many :commission_subject_tags
  has_many :tags, through: :commission_subject_tags

  validates :commission_offer, presence: true
  attr_accessor :tag_ids
  before_validation :build_tag_ids

  def build_tag_ids
    if tag_ids && tag_ids.is_a?(Array)
      self.tags = Tag.where(id: tag_ids)
    end
  end

end
