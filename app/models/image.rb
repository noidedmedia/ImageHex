##
# Image is sort of the fundamental concept of ImageHex, as the name
# implies.
# You should be pretty familiar with this file.
#
# Has one paperclip Attachment, which is "f". That's the actual image file.
# Avaliable sizes are:
# small:: A very, very tiny image. 140x140ish.
# medium:: A bit bigger, at 300x300
# large:: A decent-sized image at 500x500.
# huge:: A very big image at 1000x1000. Not really used anywhere at the moment.
#        We plan on using this size at as a third stage for our mobile app,
#        so users can download a fairly large version of a gigantic image
#        without havint to kill their bandwidth by downloading the entire thing.
#
#
# == Relationships 
# tag_groups:: Tag groups on this image. ImageHex isn't very useful without
#                these, is it?
# comments:: Much to Connor Shea's dismay, we allow comments on image. They 
#            are related in the normal polymorphatic way.
# collection_images:: This is here so the image can know what collections it
#                     is in. It's dependent: :destroy, so if the image is
#                     removed, it's automatically removed from those
#                     collections.
# 
# == Enums
# license:: What license the image is under.
# medium:: How the image was created
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
    
      path: ($IMAGE_PATH ? $IMAGE_PATH : "public/system/fs/:class/:id_:style.:extension")
  belongs_to :user

  before_post_process :downcase_extension
  has_many :tag_groups, -> {includes :tags}, dependent: :delete_all
  has_many :reports, as: :reportable, dependent: :delete_all
  has_many :notifications, as: :subject, dependent: :destroy
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
  validates :description, length:{ maximum: 2000}
  #################
  # CLASS METHODS #
  #################
  
  ##
  # Find all images a user is subscribed to. 
  # user:: The user we're finding the subscription for
  # example usage:
  #   Image.feed_for(User.first) #=> first user's image feed
  def self.feed_for(user)
    # Make activerecord generate this query, for speed:
    #
    # SELECT images.* FROM images
    # INNER JOIN collection_images ON collection_images.image_id = images.id
    # INNER JOIN subscriptions ON subscriptions.collection_id = collection_images.collection_id
    # WHERE subscriptions.user_id = ?
    # ORDER BY collection_images.created_at DESC
    
    joins("INNER JOIN collection_images ON collection_images.image_id = images.id")
      .joins("INNER JOIN subscriptions ON subscriptions.collection_id = collection_images.collection_id")
      .joins("INNER JOIN collections ON collections.id = subscriptions.collection_id")
      .where(subscriptions:{user_id: user.id})
      .order("collection_images.created_at DESC")
      .select("images.*, collections.name AS collection_name, collections.id AS collection_id")
  end
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

  ##
  # Returns a localized list of all medium options for use
  # with the select element on the Upload page.
  #
  # The text after "[I18n.t(" is the hierarchal location of the 
  # license translations in the localization file.
  def self.medium_attributes_for_select
    media.map do |medium, k|
      [I18n.t("activerecord.attributes.mediums.#{medium}"), medium]
    end
  end

  ##
  # When an image is uploaded, the extension (.jpg, .png, etc.) is forced
  # to become downcase. This is to ensure that the "Download" button will
  # always work, since some browsers don't detect files as images if their
  # extension is something like ".JPG" or another uppercase variant.
  def downcase_extension
    ext = File.extname(f_file_name).downcase
    base = File.basename(f_file_name, File.extname(f_file_name)).downcase
    self.f.instance_write :file_name, "#{base}#{ext}"
  end
end
