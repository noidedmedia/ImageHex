# frozen_string_literal: true
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
    admin?
  end

  ##
  # Checks if the user can delete the collection.
  # Can be updated if the user is an admin of the collection and the collection
  # is modifiable.
  def destroy?
    admin?
  end

  protected


  ##
  # Checks if the user is an admin of the collection.
  def admin?
    c = Curatorship.where(user: @user,
                          collection: @collection)
    c.try(:first).try(:level) == "admin"
  end
end
