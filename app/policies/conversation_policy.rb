class ConversationPolicy < ApplicationPolicy
  def initialize(user, conv)
    @user = user
    @conv = conv
  end

  def show?
    in_conversation? 
  end

  def create?
    return false unless @conv.user_ids
    if @conv.user_ids[0].is_a? String
      @conv.user_ids.include? @user.id.to_s
    else
      @conv.user_ids.include? @user.id
    end
  end

  def update?
    in_conversation?
  end

  private
  def in_conversation?
    @conv.users.include?(@user)
  end
end
