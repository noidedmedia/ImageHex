
##
# A creation is a collection which holds iamges created by a particular parson.
# It is different from uploads as it specifies not who put the image on ImageHex, but who made it in the first place.
# So if User Joe uploads the Mona Lisa, he'd put it into the created collection for Leonardo Da Vinci. 
class Creation < Collection
  before_validation :make_name

  ##
  # Since this will ony ever have one curator, we make this alias:
  def curator
    curators.first
  end
  protected
  def make_name
    self.name = "#{self.curator.name.possessive} Creations"
  end
end
