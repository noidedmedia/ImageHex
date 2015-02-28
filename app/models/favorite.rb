##
# A Favorite is a type of collection that holds a users favorite images.
class Favorite < Collection
  before_validation :fill_name, :fill_desc

  ##
  # since this will only ever have 1 curator, we make a helpful
  # alias method
  def curator
    curators.first
  end

  protected
  def fill_name
    self.name = "#{self.curator.name.possessive} Favorites"
  end

  protected
  def fill_desc
    self.description = "Images favorited by #{self.curator.name}."
  end
end
