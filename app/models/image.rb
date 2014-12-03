class Image < ActiveRecord::Base
  ## 
  # ASSOCIATIONS
  has_attached_file :f, styles: { medium: "300x300>", thumb: "100x100>" }
  belongs_to :user
  has_many :tag_groups
  
  ##
  # ENUMS
  enum license: [:public_domain, :all_rights_reserved, :cc_by, :cc_by_sa, :cc_by_nd, :cc_by_nc, :cc_by_nc_sa, :cc_by_nc_nd]
  enum medium: [:photograph, :pencil, :paint, :digital_paint, :mixed_media, :three_dimensional_render]

  ##
  # VALIDATIONS
  validates_attachment_content_type :f, content_type: /\Aimage\/.*\Z/
  validates_attachment_presence :f
  validates :user, presence: :true
  validates :license, presence: true
  validates :medium, presence: true

  ##
  # Class methods
  
  ##
  # Takes an array of tag_groups. Find all images which are in each
  # group at least once.
  def self.from_groups(p)
    # Here's how this works: We fold the groups onto each other,
    # taking those which have the same image_id as 
    p.inject do |l, n|
      l.where(image_id: n.pluc(:image_id))
    end
  end
end
