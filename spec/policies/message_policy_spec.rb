require 'rails_helper'

describe MessagePolicy do

  let(:user) { FactoryGirl.create(:user) } 
  let(:user_b){ FactoryGirl.create(:user) } 
  let(:user_c){ FactoryGirl.create(:user) } 

  let(:conv){FactoryGirl.create(:conversation,
                                user_ids: [user.id, user_b.id])}
  subject { described_class }

  permissions :show? do
    let(:msg){ FactoryGirl.create(:message,
                                 conversation: conv) } 
    it "allows if you are in the conversation" do
      expect(subject).to permit(user, msg)
    end
    it "does not allow people not in the conversation" do
      expect(subject).to_not permit(user_c, msg)
    end
  end

 
  permissions :create? do
    let(:msg){ FactoryGirl.build(:message,
                                 conversation: conv) }
    it "allows if you are in the conversation" do
      expect(subject).to permit(user, msg)
    end
    it "does not allow if not in conversation" do
      expect(subject).to_not permit(user_c, msg)
    end
  end
end
