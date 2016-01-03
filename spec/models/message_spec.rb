require 'rails_helper'

RSpec.describe Message, type: :model do
  describe "scopes" do
    describe "unread_for" do
      let(:user_a){ create(:user) }
      let(:user_b){ create(:user) }
      let(:conv){ 
        create(:conversation,
               users: [user_a, user_b])
      }
      it "shows unread messages for a user" do
        message_a = create(:message,
                           conversation: conv,
                           user: user_a)
        message_b = create(:message,
                           conversation: conv,
                           user: user_b)
        conv.mark_read!(user_a)
        message_c = create(:message,
                           conversation: conv,
                           user: user_b)
        expect(conv.messages.unread_for(user_a)).to eq([message_c])
      end
    end
  end
end
