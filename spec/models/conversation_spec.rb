require 'rails_helper'

RSpec.describe Conversation, type: :model do

  let(:usera){FactoryGirl.create(:user)}

  let(:userb){FactoryGirl.create(:user)}
  describe "creation" do
    it "save user ids to users" do
      c = Conversation.new(user_ids: [usera.id, userb.id])
      expect(c).to be_valid
    end
  end
  describe "validation" do
    let(:conv){FactoryGirl.create(:conversation)}
    it "requires at least two users" do
      conv.reload
      conv.users = [FactoryGirl.create(:user)]
      expect(conv).to_not be_valid
    end
  end
end
