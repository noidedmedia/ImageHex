class MessagePolicy < ApplicationPolicy
  def initialize(user, msg)
    @user = user
    @msg = msg
  end

  def show?
    in_conversation?
  end

  def create?
    in_conversation?
  end
  private
  def in_conversation?
    @msg.conversation.try(:users).try(:include?, @user)
  end
end
