class Tag::Topic::ReplyPolicy < ApplicationPolicy
  def initialize(user, reply)
    @user = user
    @reply = reply
  end

  def create?
    true
  end

  def update?
    @reply.user == @user
  end
end
