##
# Image is sort of the fundamental concept of ImageHex, as the name
# implies.
# You should be pretty familiar with this file.
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

  before_post_process :downcase_extension
  has_many :tag_groups, -> {includes :tags}, dependent: :delete_all
  has_many :reports, as: :reportable, dependent: :delete_all

  has_many :comments, as: :commentable, dependent: :destroy
  has_many :collection_images, dependent: :destroy

  has_many :collections, through: :collection_images
  #########
  # ENUMS #
  #########

  # What license the image is under
  enum license: [:public_domain, :all_rights_reserved, :cc_by, :cc_by_sa, :cc_by_nd, :cc_by_nc, :cc_by_nd_sa, :cc_by_nc_nd]

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
  # Search takes a query, and returns all images which match this query.
  # +q+:: array of groups to be searched for. Each group should be a comma-seperated list of tags.
  # Example usage:
  #   Image.search(["red hair, blue eyes", "brown hair, green eyes"])
  #
  def self.search(q)
    return unless q
    # This shit is messy
    # You have been warned.

    # First, properly format group names:
    names = q.map{|x| x.split(",").map{|y| y.downcase.strip.squish}}
    names.each{|x| x.reject!{|y| y  == ""}}
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

      Image.find_by_sql([query, name, name.count]).map(&:id)
    end
    ##
    # We use a fold to get common ids
    common = ids.inject{|old, x| x & old}
    where(id: common)
  end

  ##
  # Return all images by the number of reports.
  # Only returns the images which have at least 1 report.
  # TODO: rewrite this so it uses SQL and doesn't just load every freaking image into memory
  def self.by_reports
    Image.includes(:reports).select{|x| x.reports.count > 0}.sort{|x| x.reports.count}
  end

  ##
  # Returns a localized list of all license options for use
  # with the select element on the Upload page.
  #
  # The text after "[I18n.t(" is the hierarchal location of
  # the license translations in the localization file.
  def self.license_attributes_for_select
    licenses.map do |license, k|
      [I18n.t("activerecord.attributes.licenses.#{license}"), license]
    end
  end

  def self.medium_attributes_for_select
    media.map do |medium, k|
      [I18n.t("activerecord.attributes.mediums.#{medium}"), medium]
    end
  end

  def downcase_extension
    ext = File.extname(f_file_name).downcase
    base = File.basename(f_file_name).downcase
    self.f.instance_write :file_name "#{base}.#{ext}"
  end
end
