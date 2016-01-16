##
# A Pundit policy to see if users can add an image to a colletion
class CollectionImagePolicy < ApplicationPolicy
  ##
  # user:: the user trying to add an image
  # record:: the collection_image the user is trying to make
  def initialize(user, record)
    fail Pundit::NotAuthorizedError, "must be logged in" unless user
    @user = user
    @record = record
  end

  ##
  # People can add images if they curate the collection
  def create?
    user_curatorship
  end

  ##
  # People can remove images if they are an admin or a mod
  def destroy?
    user_curatorship &&
      (user_curatorship.level == "admin" || user_curatorship.level == "mod")
  end

  ##
  # The user's curatorship on the collection
  def user_curatorship
    @uc ||= Curatorship.where(user_id: @user.id,
                              collection_id: @record.collection.id).first
    @uc
  end
end
