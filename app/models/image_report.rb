class ImageReport < ActiveRecord::Base
  belongs_to :image
  belongs_to :user
  scope :active, ->{where(active: true)}
  enum reason: [
    :improperly_tagged_content, # Content ratings don't work well
    :prohibited_content, # stuff we don't allow
    :illegal_content # Things that are illegal
  ]
end
