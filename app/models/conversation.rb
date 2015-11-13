class Conversation < ActiveRecord::Base
  has_many :conversation_users
  has_many :users, through: :conversation_users
  has_many :messages
  validate :has_two_or_more_users
  attr_accessor :user_ids
  before_validation :save_user_ids, on: :create

  protected

  def has_two_or_more_users
    unless self.users.length > 1
      errors[:users] << "needs at least 2"
    end
  end
  def save_user_ids
    self.users = User.where(id: user_ids) unless self.users.count > 0 
  end

end
