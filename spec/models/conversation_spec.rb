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
  end
end
