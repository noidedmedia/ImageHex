require 'rails_helper'

RSpec.describe Conversation, type: :model do
  context "with an attached commission offer" do
    let(:o) do 
      c = create(:commission_offer)
      c.confirm!
      c
    end
    let(:c){ o.conversation }

    it "exists" do
      expect(c).to_not be(nil)
    end
    it "says it is #for_offer" do
      expect(c).to be_for_offer
    end
  end
  describe "nested attributes" do
    let(:user_a){ create(:user) }
    let(:user_b){ create(:user) }
    let(:users){ [user_a, user_b] }
    let(:users_attributes){ users.map{|u| {user_id: u.id} } }
    it "creates conversation users" do
      expect{
        Conversation.create(conversation_users_attributes: users_attributes)
      }.to change{ConversationUser.count}.by(2)
    end
    it "associates the users properly" do
      c = Conversation.create(conversation_users_attributes: users_attributes)
      expect(c.users).to contain_exactly(*users)
    end
  end

end
