class CuratorshipPolicy < ApplicationPolicy
  def initialize(user, curatorship)
    @user = user
    @curatorship = curatorship
    @user_curatorship = Curatorship.where(user_id: @user.id,
                                          collection_id: curatorship.collection.id)
      .first
  end
  def update?
    is_admin?
  end

  def delete?
    is_admin?
  end
  def create?
    is_admin?
  end

  protected
  def is_admin?
    @user_curatorship.try(:level) == "admin"
  end
end
