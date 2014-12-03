class Image < ActiveRecord::Base
  ################
  # ASSOCIATIONS #
  ################
  has_attached_file :f, styles: { medium: "300x300>", thumb: "100x100>" }
  belongs_to :user
  has_many :tag_groups
  
  #########
  # ENUMS #
  #########
  
  # What license the image is under
  enum license: [:public_domain, :all_rights_reserved, :cc_by, :cc_by_sa, :cc_by_nd, :cc_by_nc, :cc_by_nc_sa, :cc_by_nc_nd]
  # What kind of image this is
  enum medium: [:photograph, :pencil, :paint, :digital_paint, :mixed_media, :three_dimensional_render]

  ###############
  # VALIDATIONS #
  ###############
  validates_attachment_content_type :f, content_type: /\Aimage\/.*\Z/
  validates_attachment_presence :f
  validates :user, presence: :true
  validates :license, presence: true
  validates :medium, presence: true

  #################
  # CLASS METHODS #
  #################

  
  ##
  # Take an ARRAY of COLLECTIONS of groups.
  # Find all images which have at least one member from EACH COLLECTION
  # This is done to allow people to search by two or more tag groups.
  # So if they want to see an image where Donald Trump is wrestling
  # with Vince McMahon, they can search "donald trump, wrestling" and
  # "vine mcmahon, wrestling"
  def self.from_groups(group)
    # First, we fold the group over onto itself, selecting groups only if
    # their image id is in the next group.
    # Folds are a pretty high-level functional programming concept. Be sure
    # to look up what it does if you don't get it.
    group.inject do |l, r|
      l.where(image_id: r.pluck(:image_id))
    end
    ##
    # Now, the only groups which remain belong to images that match the
    # query as a whole. Thus, we can simply grab the image_id.
    self.where(id: group.pluck(:image_id))
  end
end
