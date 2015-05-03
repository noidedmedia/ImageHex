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
  ##
  # The HTML-safe string to display
  def display
    @@redcarpet ||= Redcarpet::Markdown.new(Redcarpet::Render::HTML.new)
    @@redcarpet.render(body)
  end
end
