##
# A creation is a collection which holds iamges created by a particular parson.
# It is different from uploads as it specifies not who put the image on
# ImageHex, but who made it in the first place.
# So if User Joe uploads the Mona Lisa, he'd put it into the created 
# collection for Leonardo Da Vinci.
# 
# A user's innate creations collection is images they've created. Currently
# there's no way to create Creation collections, so that's the only type.
# When it's not, we're going to add a boolean field asking if it's innate.
# If it is, the user will not be able to:
# * Add more curators to it
# * Delete it
class Creation < Collection
  before_validation :make_name

  def self.model_name
    Collection.model_name
  end
  ##
  # Currently, this is an alias for curators.first. We use this as innate 
  # creations collections are the only type of creation collection. When 
  # this changes, we're probably just gonna remove this method.
  def curator
    curators.first
  end

  protected
  ##
  # Gives the collection the title of "#{User}'s collection", basically.
  #
  # ...
  #
  # Yeah, holy shit, this entire thing is built with Creation being
  # user-specific in mind. You probably realized that by now. 
  # TODO: Make our first intern suffer by refactoring all this.
  def make_name
    self.name = "#{self.curator.name.possessive} Creations"
  end
end
