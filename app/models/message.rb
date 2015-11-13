class Message < ActiveRecord::Base
  belongs_to :conversation
  belongs_to :user

  validates :conversation, presence: true
  validates :user, presence: true
  validate :in_conversation


  private
  def in_conversation
    unless conversation.try(:users).try(:include?, user)
      errors[:conversation] << "must be a user in this conversation"
    end
  end
end
