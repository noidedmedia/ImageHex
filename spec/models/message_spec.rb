require 'rails_helper'

RSpec.describe Message, type: :model do
  describe "scopes" do
    describe "relating to reading" do
      let(:user_a){ create(:user) }
      let(:user_b){ create(:user) }
      let(:conv){ 
        create(:conversation,
               users: [user_a, user_b])
      }
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
