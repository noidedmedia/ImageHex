class CollectionImagePolicy < ApplicationPolicy
  def initialize(user, record)
    raise Pundit::NotAuthorizedError, "must be logged in" unless user
    @user = user
    @record = record
  end

  def create?
    @user.curatorship_for(@record.collection)
  end

  def delete?
    (c = @user.curatorsip_for(@record.collection)) &&
      (c.level == :mod || c.level == :admin)
  end
end
