class Image < ActiveRecord::Base
  ################
  # ASSOCIATIONS #
  ################
  has_attached_file :f, 
    # Steal Flickr's suffixes
    :styles => { 
      small: "140x140>",
      medium: "300x300>",
      large: "500x500>",
      huge: "1000x1000>"},
    # Use suffixes for the path
      path: "public/system/fs/:class/:id_:style.:extension"

  belongs_to :user

  has_many :tag_groups

  has_many :reports, as: :reportable
  
  has_many :collection_images
  
  has_many :collections, through: :collection_images
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
  

  def self.search(q)
    # This shit is messy
    # You have been warned.

    # First, properly format group names:
    names = q.map{|x| x.split(",").map{|y| y.downcase.strip.squish}}
    ##
    # Now we have:
    # [ [names for tags in a group], [names for another group]]
    # We first do set division to find valid images
    # Query is like this:
    query = %q{
    SELECT tag_groups.image_id AS "id"
      FROM tag_groups
        INNER JOIN tag_group_members
          ON tag_groups.id = tag_group_members.tag_group_id
        INNER JOIN tags
          ON tags.id = tag_group_members.tag_id
        WHERE tags.name IN (?)
        GROUP BY tag_groups.id
        HAVING COUNT(*) = ?
    }
    ids = names.map do |name|
      
      # Query is above
      # We have 2 values to insert: the tag names, and
      # the number of tag names.
      
      d = Image.find_by_sql([query, name, name.count])
      puts d.inspect
      d
    end
    puts ids.inspect
  end 
  
  ##
  # Takes an array of tag_groups. Find all images which are in each
  # group at least once.
  def self.from_groups(p)
    # Here's how this works: We fold the groups onto each other,
    # taking those which have the same image_id as 
    p.inject do |l, n|
      l.where(image_id: n.pluck(:image_id))
    end
  end
  def self.by_reports
    Image.all.select{|x| x.reports.count > 0}.sort{|x| x.reports.count}
  end
end
