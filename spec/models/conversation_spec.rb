# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Conversation, type: :model do

  describe "user_ids" do
    let(:ua) { create(:user) }
    let(:ub) { create(:user) }
  end
  describe "nested attributes" do
    let(:user_a) { create(:user) }
    let(:user_b) { create(:user) }
    let(:users) { [user_a, user_b] }
    let(:users_attributes) { users.map { |u| { user_id: u.id } } }
    it "creates conversation users" do
      expect do
        Conversation.create(conversation_users_attributes: users_attributes)
      end.to change { ConversationUser.count }.by(2)
    end
    it "associates the users properly" do
      c = Conversation.create(conversation_users_attributes: users_attributes)
      expect(c.users).to contain_exactly(*users)
    end
  end

  describe ".mark_read(user)" do
    let(:user_a) { create(:user) }
    let(:user_b) { create(:user) }
    let(:conversation) do
      create(:conversation, users: [user_a, user_b])
    end
    it "raises an error if the user is not in the conversation" do
      expect do
        conversation.mark_read!(create(:user))
      end.to raise_error(Conversation::UserNotInConversation)
    end
    it "changes the user's last read at time" do
      cu = conversation.conversation_users.where(user: user_a).first
      Timecop.freeze do
        t = Time.zone.now
        expect do
          conversation.mark_read!(user_a)
        end.to change { cu.reload.last_read_at }.to be_within(5.minutes).of(t)
      end
    end
  end

  describe ".with_unread_status_for" do
    let(:user_a) { create(:user) }
    let(:user_b) { create(:user) }
    let(:user_c) { create(:user) }
    let(:conv_a) { create(:conversation,
                          users: [user_a, user_b]) }
    let(:conv_b) { create(:conversation,
                          users: [user_a, user_c]) }
    it "shows the unread status for users" do
      conv_b.messages.create(user: user_c,
                             body: "Test")
      conv_b.mark_read!(user_a)
      conv_a.messages.create(user: user_b,
                             body: "test")
      convs = user_a.conversations.with_unread_status_for(user_a).uniq
      ca = convs.to_a.select(&:has_unread).first
      cb = convs.to_a.reject(&:has_unread).first
      expect(ca.id).to eq(conv_a.id)
      expect(cb.id).to eq(conv_b.id)
    end
  end
  describe ".messages_for_user" do
    let(:user_a) { create(:user) }
    let(:user_b) { create(:user) }
    let(:conversation) do
      create(:conversation, users: [user_a, user_b])
    end
    it "throws an error if the user isn't in the conversation" do
      expect do
        conversation.messages_for_user(create(:user))
      end.to raise_error(Conversation::UserNotInConversation)
    end
    it "returns messages made after this user's last_read_at" do
      create(:message,
             conversation: conversation,
             user: user_b)
      create(:message,
             conversation: conversation,
             user: user_a)
      conversation.mark_read!(user_a)
      m3 = create(:message,
                  conversation: conversation,
                  user: user_b)
      m4 = create(:message,
                  conversation: conversation,
                  user: user_b)
      res = conversation.messages_for_user(user_a)
      expect(res).to contain_exactly(m3, m4)
    end
  end
end
