class CuratorshipPolicy < ApplicationPolicy
  def initialize(user, curatorship))
    @user = user
    @curatorship = curatorship
  end
  def promote?
    (c = @user.curatorship_for(@curatorship.collection)) && c.level == :admin
  end

  def delete?
    (c = @user.curatorship_for(@curatorship.collection)) && c.level == :admin
  end
  def create?
    (c = @user.curatorship_for(@curatorship.collection)) && c.level == :admin
  end
end
