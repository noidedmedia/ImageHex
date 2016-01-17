##
# A policy to see if a user can modify a  curatorship
class CuratorshipPolicy < ApplicationPolicy
  ##
  # Set it up
  # user:: the user attempting to modify a curatorship
  def initialize(user, curatorship)
    @user = user
    @curatorship = curatorship
    @user_curatorship = Curatorship.where(user_id: @user.id,
                                          collection_id: curatorship.collection.id)
      .first
  end

  ##
  # A user can modify a curatorship if they are an admin
  def update?
    admin?
  end

  ##
  # A user can delete a curatorship if they are an admin
  def delete?
    admin?
  end

  ##
  # A user can create a curatorship if they are an admin
  def create?
    admin?
  end

  protected

  ##
  # See if the user is an admin of this collection
  def admin?
    @user_curatorship.try(:level) == "admin"
  end
end
