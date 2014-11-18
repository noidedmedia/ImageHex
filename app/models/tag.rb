class Tag < ActiveRecord::Base
  ##
  # CALLBACKS:
  before_save :fix_name

  ##
  # ASSOCIATIONS:
  has_many :tag_group_members
  has_many :tag_groups, through: :tag_group_members

  private
  def fix_name
    self.name = self.name.strip.squish.downcase
  end
end
