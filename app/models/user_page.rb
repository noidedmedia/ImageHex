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
  validate :elsewhere_has_valid_keys
  def elsewhere_has_valid_keys
    errors.add(:elsewhere, "must be a has") unless self.elsewhere.is_a? Hash
    unless elsewhere.keys - ALLOWED_ELSEWHERE_KEYS == []
      errors.add(:elsewhere, "Elsewhere has weird data")
    end
  end

  ##
  # Allowed keys for Elsewhere
  #
  ALLOWED_ELSEWHERE_KEYS = [
    "tumblr",
    "facebook",
    "twitter",
    "deviantart",
    "personal_website"
  ]

end
