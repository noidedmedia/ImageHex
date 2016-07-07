# frozen_string_literal: true
class Conversation < ActiveRecord::Base
  has_many :conversation_users, inverse_of: :conversation
  has_many :users, through: :conversation_users
  has_many :messages

  accepts_nested_attributes_for :conversation_users

  belongs_to :order,
    required: false

  attr_accessor :auto_accept

  after_create :accept_all_users, :if => :auto_accept
  after_create :notify_cables

  validate :conversation_has_unique_users

  ##########
  # SCOPES #
  ##########

  def self.with_unread_status_for(u)
    raise "Not a user" unless u.is_a? User
    includes(:conversation_users)
      .includes(:users)
      .where(conversation_users: { user_id: u.id})
      .select(%{
  conversations.*,
  (conversations.last_message_at > conversation_users.last_read_at) AS has_unread,
  (conversation_users.last_read_at) AS last_read_time
      })
      .references(:conversation_users)
  end

  def self.find_with_exact_user_ids(ids)
    subquery = joins(:conversation_users)
      .references(:conversation_users)
      .group("conversations.id")
      .having("COUNT(conversation_users) != ?", ids.length)

    joins(:conversation_users)
      .references(:conversation_users)
      .where(conversation_users: {user_id: ids})
      .group("conversations.id")
      .having("COUNT(conversation_users) = ?", ids.length)
      .where.not(id: subquery).first
  end

  ####################
  # INSTANCE METHODS #
  ####################

  def all_users_accepted?
    conversation_users.where(accepted: [false, nil]).count == 0
  end
   ##
  # Hack because we do a custom thing in our SELECT sometimes
  def has_unread?
    attributes["has_unread"]
  end

  class UserNotInConversation < StandardError
  end

  def mark_read!(user)
    cu = conversation_user_for(user)
    raise UserNotInConversation unless cu
    cu.touch(:last_read_at)
  end

  def messages_for_user(user)
    # rubocop:disable Lint/AssignmentInCondition
    if cu = conversation_user_for(user)
      if timestamp = cu.last_read_at
        # rubocop:enable Lint/AssignmentInCondition
        messages.where("created_at > ?", timestamp)
      else
        messages
      end
    else
      raise UserNotInConversation
    end
  end

  def conversation_user_for(user)
    conversation_users.find_by(user: user)
  end

  def last_read_for(user)
    conversation_user_for(user).last_read_at
  end

  private

  def notify_cables
    NewConversationJob.perform_later(self)
  end

  def accept_all_users
    conversation_users.update_all(accepted: true)
  end
  
  def conversation_has_unique_users
    return unless order.nil?
    q = Conversation.where(order: nil).find_with_exact_user_ids(self.user_ids)
    unless q.nil?
      errors.add(:users, "conversation with these users already exists")
    end
  end

end
