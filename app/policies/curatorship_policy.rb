# frozen_string_literal: true
##
# A policy to see if a user can modify a  curatorship
class CuratorshipPolicy < ApplicationPolicy
  ##
  # Set it up
  # user:: the user attempting to modify a curatorship
  def initialize(user, curatorship)
    @user = user
    @curatorship = curatorship
    c_id = curatorship.collection_id
    @user_curatorship = Curatorship.where(user_id: @user.id,
                                          collection_id: c_id)
      .first
  end

  ##
  # A user can modify a curatorship if they are an admin of the collection.
  def update?
    admin?
  end

  ##
  # A user can delete a curatorship if they are an admin of the collection.
  def delete?
    admin?
  end

  ##
  # A user can add another curator if they are an admin of the collection.
  def create?
    admin?
  end

  protected

  ##
  # Check if the user is an admin of this collection.
  def admin?
    @user_curatorship.try(:level) == "admin"
  end
end
