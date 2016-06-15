# frozen_string_literal: true
class ConversationUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :conversation
  validates :user, presence: true
  validates :conversation, presence: true
  before_create :set_initial_read_date

  delegate :for_offer?, to: :conversation, prefix: true

  protected

  def set_initial_read_date
    self.last_read_at = Time.zone.now
  end
end
