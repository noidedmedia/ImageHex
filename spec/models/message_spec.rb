# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Message, type: :model do
  describe "scopes" do
    describe ".posted_since" do
      it "gives messages posted since a certain date" do
        b = create(:message)
        a = create(:message)
        expect(Message.posted_since(b.created_at)).to eq([a])
      end
    end

    context "relating to reading" do
      let(:user_a) { create(:user) }
      let(:user_b) { create(:user) }
      let(:conv) do
        create(:conversation,
               users: [user_a, user_b])
      end
      context "with multiple conversations" do
        describe ".unread_for" do
          it "shows unread messages" do
            conv_b = create(:conversation,
                            users: [user_a, user_b])
            create(:message,
                   user: user_b,
                   conversation: conv)
            msg_b = create(:message,
                           user: user_b,
                           conversation: conv_b)
            conv.mark_read!(user_a)
            expect(Message.unread_for(user_a)).to eq([msg_b])
          end
        end
      end
      context "across one converation" do
        before(:each) do
          @message_a = create(:message,
                              conversation: conv,
                              user: user_a)
          @message_b = create(:message,
                              conversation: conv,
                              user: user_b)
          conv.mark_read!(user_a)
          @message_c = create(:message,
                              conversation: conv,
                              user: user_b)
        end
        describe ".unread_for" do
          it "shows unread messages" do
            expect(conv.messages.unread_for(user_a)).to eq([@message_c])
          end
          it "restricts to messages the user can see" do
            expect(conv.messages.unread_for(create(:user))).to eq([])
          end
        end
        describe ".with_read_status_for" do
          it "shows read status" do
            m = conv
              .messages
              .with_read_status_for(user_a)
              .order(created_at: :asc)

            expect(m.map(&:read)).to eq([true, true, false])
          end
        end
      end
    end
  end
end
