##
# A Favorite is a type of collection that holds a users favorite images.
# A favorites collection is rather special:
# * They cannot be deleted
# * Every user has one
# * They cannot gain new curators
# * They cannot be abandoned
#
# For this reason, we generally don't reveal to the user that their favorites
# are a type of collection. After all, they don't behave anything like
# collections, besides the entire add/remove images part.
#
# "BUT WAIT," you ask, "WHY MAKE IT A COLLECTION AT ALL?"
#
# Well, that's pretty simple to answer. See, it's a hell of a lot nicer
# on our DB to select all images a user is subscribed too in one big SELECT
# (as far as I know, at least). Doing it this way basically lets us do that.
# See the actual code for a user's image_feed for more detail.
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
