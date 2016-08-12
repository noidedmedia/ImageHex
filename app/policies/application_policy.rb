# frozen_string_literal: true
##
# This class provides a base for all the other Pundit policies to inherit from
# Currently, it does nothing, since there's no shared functionality between
# policies
class ApplicationPolicy
  class Scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope.all
    end
  end

  def edit?
    update?
  end

  def new?
    create?
  end
end
