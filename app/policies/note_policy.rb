class NotePolicy < ApplicationPolicy
  def initialize(user, note)
    @user, @note = user, note
  end

  def create?
    @user
  end

  def edit?
    @user == @note.user
  end

  def update?
    @user
  end
end
