class Image < ActiveRecord::Base
  belongs_to :user
  ##
  # The actual image file is referenced with f
  has_attached_file :f, styles: { medium: "300x300>", thumb: "100x100>" }
  validates_attachment_content_type :f, content_type: /\Aimage\/.*\Z/
  validates_attachment_presence :f
  validates :user, presence: :true
end
