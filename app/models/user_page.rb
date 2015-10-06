##
# UserPage is a bit of text describing a user. 
# Each user has exactly one.
# The text is stored in page.body and processed via Markdown.
class UserPage < ActiveRecord::Base
  belongs_to :user

  ###############
  # VALIDATIONS #
  ###############
  validates :user, presence: true
  before_create :set_default_elsewhere
  validate :elsewhere_is_valid

  def set_default_elsewhere
    self.elsewhere = []
  end

  def elsewhere_is_valid
    unless elsewhere.is_a? Array
      errors.add(:elsewhere, "must be an array")
      return
    end
    elsewhere.each do |e|
      unless e =~ /\A#{URI::regexp(['http', 'https'])}\z/
        errors.add(:elsewhere, "must be full of valid URIs")
      end
      unless ALLOWED_ELSEWHERE.include URI.parse(e).host 
        errors.add(:elsewhere, "a link is not suppored")
      end
    end
  end

  ALLOWED_ELSEWHERE = ["twitter.com",
    "tumblr.com",
    "facebook.com",
    "deviantart.com"]

end
