class Tag < ActiveRecord::Base
  ##
  # CALLBACKS:
  before_save :fix_name

  ##
  # ASSOCIATIONS:
  has_many :tag_group_members
  has_many :tag_groups, through: :tag_group_members

  validates :name, uniqueness: {case_sensative: false}
  def self.suggest(n)
    query = %q{
    SELECT tags.name FROM tags
    WHERE tags.name LIKE ?
    }
    finder = "#{n.gsub("%","")}%"
    find_by_sql([query, finder]).map(&:name)
  end
  private
  def fix_name
    self.display_name ||= self.name
    self.name = self.name.strip.squish.downcase
  end

end
