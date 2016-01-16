require 'rails_helper'

RSpec.describe ConversationUser, type: :model do
  context "when attached to a commission" do
    let(:o) do
      c = create(:commission_offer)
      c.confirm!
      c
    end
    let(:c) { o.conversation }
    it "does not allow other users to be created" do
      expect(build(:conversation_user,
                   conversation: c,
                   user: create(:user))).to_not be_valid
    end
  end
end
