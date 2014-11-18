class Tag < ActiveRecord::Base
  before_save :fix_name

  private
  def fix_name
    self.name = self.name.strip.squish.downcase
  end
end
