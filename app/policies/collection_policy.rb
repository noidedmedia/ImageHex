class CollectionPolicy < ApplicationPolicy
  def initialize(user, collection)
    @user = user
    @collection = collection
  end

  ##
  # Checks if the user can update the collection.
  # Can be deleted if the user is an admin of the collection and the collection
  # is modifiable.
  def update?
    admin? && non_innate?
  end

  ##
  # Checks if the user can delete the collection.
  # Can be updated if the user is an admin of the collection and the collection
  # is modifiable.
  def destroy?
    admin? && non_innate?
  end

  protected

  ##
  # Checks if the collection is of a "non-innate" type.
  # Innate types can be modified, collections like a user's Favorites or
  # Creations cannot be modified.
  def non_innate?
    case @collection.type
    when "Favorite"
      false
    when "Creation"
      false
    else
      true
    end
  end

  ##
  # Checks if the user is an admin of the collection.
  def admin?
    c = Curatorship.where(user: @user,
                          collection: @collection)
    c.try(:first).try(:level) == "admin"
  end
end
