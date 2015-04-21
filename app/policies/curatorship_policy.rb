class CuratorshipPolicy < ApplicationPolicy
  def initialize(user, curatorship)
    @user = user
    @curatorship = curatorship
    @user_curatorship = Curatorship.where(user_id: @user.id,
                                          collection_id: curatorship.collection.id)
      .first
  end
  def update?
    @user_curatorship && @user_curatorship.level == "admin"
  end

  def delete?
   @user_curatorship  && @user_curatorship.level == "admin"
  end
  def create?
    @user_curatorship && @user_curatorship.level == "admin"
  end
end
