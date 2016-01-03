class ConversationPolicy < ApplicationPolicy
  def initialize(user, conv)
    @user = user
    @conv = conv
  end

  def show?
    @conv.users.include?(@user)
  end
end
