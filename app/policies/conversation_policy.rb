class ConversationPolicy < ApplicationPolicy
  def initialize(user, conv)
    @user = user
    @conv = conv
  end

  def show?
    in_conversation? 
  end

  def create?
    @conv.user_ids.include?(@user.id)
  end

  def update?
    in_conversation?
  end

  private
  def in_conversation?
    @conv.users.include?(@user)
  end
end
