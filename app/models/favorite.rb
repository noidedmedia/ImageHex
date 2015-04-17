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
    self.name = I18n.t "favorites_collection_title", usernames: "#{self.curator.name.possessive}"
  end

  protected
  def fill_desc
    self.description = I18n.t "favorites_collection_description", username: "#{self.curator.name}"
  end
end
