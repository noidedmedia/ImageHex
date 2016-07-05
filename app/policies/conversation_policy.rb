# frozen_string_literal: true
class ConversationPolicy < ApplicationPolicy
  def initialize(user, conv)
    @user = user
    @conv = conv
  end

  def show?
    in_conversation?
  end

  def update?
    in_conversation?
  end

  def create?
    true
  end

  protected
  def in_conversation?
    @conv.users.include? @user
  end
end
