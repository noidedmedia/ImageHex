class Creation < Collection
  before_validation :make_name

  protected
  def make_name
    self.name = "#{self.user.name.possessive} Creations"
  end
end
