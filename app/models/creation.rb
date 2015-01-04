class Creation < Collection
  before_validation :make_name

  ##
  # Since this will ony ever have one curator, we make this alias:
  def user
    users.first
  end
  protected
  def make_name
    self.name = "#{self.user.name.possessive} Creations"
  end
end
