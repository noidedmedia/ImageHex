class BackgroundReference < ActiveRecord::Base
  belongs_to :commission_background
  has_attached_file :file,
    styles: {thumnail: "200x200"},
    s3_permissions: :private,
    path: ($BACKGROUND_REF_PATH ? $BACKGROUND_REF_PATH :  "backround_refs/:id_:style.:extension")
  validates_attachment :file,
    presence: true
  validates_attachment_content_type :file,
    content_type: /\Aimage\/.*\Z/
end
