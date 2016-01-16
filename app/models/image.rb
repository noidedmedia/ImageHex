#
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
  ##############
  # ATTRIBUTES #
  ##############
  attr_accessor :created_by_uploader

  #############
  # CALLBACKS #
  #############

  after_create :add_uploader_creation

  ##########
  # SCOPES #
  ##########

  scope :without_nudity, -> { where(nsfw_nudity: false) }
  scope :without_gore, -> { where(nsfw_gore: false) }
  scope :without_language, -> { where(nsfw_language: false) }
  scope :without_sex, -> { where(nsfw_sexuality: false) }
  scope :completely_safe, -> { without_nudity.without_gore.without_language.without_sex }
  scope :mostly_safe, -> { without_nudity.without_gore.without_sex }
  ################
  # ASSOCIATIONS #
  ################
  has_attached_file :f,
                    # Steal Flickr's suffixes
                    styles: {
                      small: "140x140>",
                      medium: "300x300>",
                      large: "500x500>",
                      huge: "1000x1000>" },
                    # Use suffixes for the path
                    path: ($IMAGE_PATH ? $IMAGE_PATH : ":id_:style.:extension")
  belongs_to :user, touch: true

  before_post_process :downcase_extension
  has_many :tag_groups, -> { includes :tags }, dependent: :delete_all
  has_many :image_reports
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :collection_images, dependent: :destroy
  has_many :user_creations,
           foreign_key: :creation_id
  has_many :creators,
           through: :user_creations,
           source: :user
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
  validates :nsfw_language, inclusion: { in: [true, false] }
  validates :nsfw_gore, inclusion: { in: [true, false] }
  validates :nsfw_sexuality, inclusion: { in: [true, false] }
  validates :nsfw_nudity, inclusion: { in: [true, false] }
  validates_attachment :f,
                       content_type: { content_type: /\Aimage\/.*\Z/ },
                       presence: true

  validates :user, presence: :true
  validates :license, presence: true
  validates :medium, presence: true
  validates :description, length: { maximum: 2000 }

  validate :is_within_allowed_size
  #################
  # CLASS METHODS #
  #################

  def self.by_popularity(interval = 2.weeks.ago..Time.now)
    imgs = Image.arel_table
    cimgs = CollectionImage.arel_table
    j = imgs.join(cimgs, Arel::Nodes::OuterJoin)
      .on(cimgs[:image_id].eq(imgs[:id]), cimgs[:created_at].between(interval))
      .join_sources
    res = joins(j)
      .group("images.id")
      .order("COUNT (collection_images) DESC")
  end

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
    SubscriptionQuery.new(user).result
      .order("sort_created_at DESC")
      .for_content(user.content_pref)
  end

  def self.with_all_tags(tags)
    tags.reject!(&:blank?) # reject blank tags
    ## Clear previous scope to construct a subquery
    sq = Image.unscoped.joins(tag_groups: { tag_group_members: :tag })
      .where(tags: { id: tags })
      .group("images.id")
      .having("COUNT(*) >= ?", tags.length)
    where(id: sq)
  end

  def self.search(q)
    # return nothing unless we have a query
    return where("1 = 0") unless q.is_a? SearchQuery
    query = all
    q.each_group_tag_ids do |group|
      query = query.with_all_tags(group)
    end
    query
  end

  ##
  # Return all images by the number of reports.
  # Only returns the images which have at least 1 report.
  def self.by_reports
    joins(:image_reports)
      .references(:image_reports)
      .where(image_reports: { active: true })
      .group(:id).order("COUNT(image_reports)")
  end

  def self.without_tags(tags)
    subq = joins(tag_groups:  { tag_group_members: :tag })
      .where.not(tags: { name: tags })
    where(id: subq)
  end

  def self.for_content(content)
    q = all
    q = q.without_nudity unless content["nsfw_nudity"]
    q = q.without_gore unless content["nsfw_gore"]
    q = q.without_language unless content["nsfw_language"]
    q = q.without_sex unless content["nsfw_sexuality"]
    q = q.without_tags(content["disallowed_tags"]) if content["disallowed_tags"]
    q
  end

  ##
  # Returns a localized list of all license options for use
  # with the select element on the Upload page.
  #
  # The text after "[I18n.t(" is the hierarchal location of
  # the license translations in the localization file.
  def self.license_attributes_for_select
    licenses.map do |license, _k|
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
    media.map do |medium, _k|
      [I18n.t("activerecord.attributes.mediums.#{medium}"), medium]
    end
  end

  def source_display
    URI.parse(source_link).host
  end

  def created_by?(user)
    creators.include? user
  end

  def source_link
    if source.start_with?("http://", "https://")
      source
    else
      "//#{source}"
    end
  end

  protected

  def add_uploader_creation
    # This is gross beecause of how form params work
    if created_by_uploader.is_a? TrueClass
      user.creations << self
    elsif created_by_uploader.is_a? String
      user.creations << self if %w(true 1).include?(created_by_uploader)
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
    f.instance_write :file_name, "#{base}#{ext}"
  end

  def is_within_allowed_size
    unless (0..5.megabytes).cover?(f_file_size)
      errors.add(:f, I18n.t("notices.image_file_too_large"))
    end
  end
end
