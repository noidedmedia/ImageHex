class CollectionPolicy < ApplicationPolicy
  def initialize(user, collection)
    @user = user
    @collection = collection
  end

  def destroy?
    admined?

  end

  protected
  def admined?
    Curatorship.where(user: @user,
                      collection: @collection)
    .try(:first)
    .try(:level) == "admin"
  end
end
