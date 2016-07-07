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

  describe ".all_users_accepted?" do
    let(:user_a) { create(:user) }
    let(:user_b) { create(:user) }
    let(:users) { [user_a, user_b] }

    it "returns true when all accepted" do
      c = Conversation.create(users: users, name: "test")
      c.conversation_users.update_all(accepted: true)
      expect(c.reload.all_users_accepted?).to eq(true)
    end

    it "returns false with undecided" do
      c = Conversation.create(users: users, name: "test")
      expect(c.all_users_accepted?).to eq(false)
    end

    it "returns false when rejected" do
      c = Conversation.create(users: users, name: "test")
      c.conversation_users.first.update(accepted: false)
      expect(c.all_users_accepted?).to eq(false)
    end
  end

  describe ".autoaccept" do
    let(:user_a) { create(:user) }
    let(:user_b) { create(:user) }
    it "sets the conversation as automatically accepted" do
      c = Conversation.create(users: [user_a, user_b],
                              name: "Test",
                              auto_accept: true)
      expect(c.all_users_accepted?).to eq(true)
    end
  end

  describe "conversations with the same participants" do
    let(:user_a) { create(:user) }
    let(:user_b) { create(:user) }

    it "does not allow multiple normal conversations" do
      a = create(:conversation, users: [user_a, user_b])
      b = build(:conversation, users: [user_a, user_b])
      expect(b).to_not be_valid
    end

    context "with orders" do
      let(:listing) { create(:listing, user: user_a) } 
      let(:order)  { create(:order, listing: listing, user: user_b) }

      it "ignores existing order conversations when creating a normal one" do
        a = create(:conversation, users: [user_a, user_b], order: order)
        b = build(:conversation, users: [user_a, user_b])
        expect(b).to be_valid
      end

      it "ignores existing normal conversations when creating an order one" do 
        a = create(:conversation, users: [user_a, user_b])
        b = build(:conversation, users: [user_a, user_b], order: order)
        expect(b).to be_valid
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
                          users: [user_a, user_c],
                          auto_accept: true) }
    it "shows the unread status for users" do
      conv_b.messages.create(user: user_c,
                             body: "Test")
      conv_b.mark_read!(user_a)
      conv_a.messages.create(user: user_b,
                             body: "test")
      convs = user_a.conversations.with_unread_status_for(user_a).distinct
      ca = convs.to_a.select(&:has_unread).first
      cb = convs.to_a.reject(&:has_unread).first
      expect(ca.id).to eq(conv_a.id)
      expect(cb.id).to eq(conv_b.id)
    end
  end
end
