class SubjectReference < ActiveRecord::Base
  belongs_to :commission_subject
  has_attached_file :file,
                    styles: { thumbnail: "200x200" },
                    s3_permissions: :private,
                    path: ($SUBJECT_REF_PATH ? $SUBJECT_REF_PATH : "subject_refs/:id_:style.:extension")

  validates_attachment :file,
                       content_type: { content_type: /\Aimage\/.*\Z/ },
                       presence: true
  validates_attachment_content_type :file,
                                    content_type: /\Aimage\/.*\Z/
end
