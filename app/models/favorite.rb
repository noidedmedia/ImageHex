class Favorite < Collection
  before_validation :fill_name

  protected
  def fill_name
    self.name = "#{self.user.name.possessive} Favorites"
  end
end
