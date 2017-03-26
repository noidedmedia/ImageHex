class Note::ReplyPolicy < ApplicationPolicy
  def initialize(user, reply)
    @user, @note = user, reply
  end

  def show?
    true
  end

  def create?
    true
  end

  def update?
    @reply.user == @user
  end
end
