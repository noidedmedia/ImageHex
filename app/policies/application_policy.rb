##
# This class provides a base for all the other Pundit policies to inherit from
# Currently, it does nothing, since there's no shared functionality between
# policies
class ApplicationPolicy
  def edit?
    update?
  end

  def new?
    create?
  end
end
