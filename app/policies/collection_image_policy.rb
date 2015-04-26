class CollectionImagePolicy < ApplicationPolicy
  def initialize(user, record)
    raise Pundit::NotAuthorizedError, "must be logged in" unless user
    @user = user
    @record = record
  end

  def create?
    user_curatorship
  end

  def destroy?
    user_curatorship && 
      (user_curatorship.level == "admin" || user_curatorship.level  == "mod")
  end

  def user_curatorship
    @uc ||= Curatorship.where(user_id: @user.id,
                              collection_id: @record.collection.id).first
    @uc
  end
end
