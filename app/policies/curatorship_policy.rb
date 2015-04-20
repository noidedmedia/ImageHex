class CuratorshipPolicy < ApplicationPolicy
  def initialize(user, curatorship))
    @user = user
    @curatorship = curatorship
    @user_curatorship = Curatorship.where(user_id: @user.id,
                                          collection_id: curatorship.collection.id)
      .first
  end
  def promote?
    @user_curatorship && c.level == :admin
  end

  def delete?
   @user_curatorship  && c.level == :admin
  end
  def create?
    @user_curatorship && c.level == :admin
  end
end
