require 'rails_helper'

describe ConversationPolicy do

  let(:usera) { FactoryGirl.create(:user) }
  let(:userb) { FactoryGirl.create(:user) } 
  let(:conv){ FactoryGirl.create(:conversation,
                                 users: [usera, userb]) }
  let(:userc) { FactoryGirl.create(:user) } 
  before(:each) do
    conv.users = [usera, userb]
  end

  subject { described_class }
  permissions :show? do
    it { should permit(usera, conv) }
    it { should permit(userb, conv) }
    it { should_not permit(userc, conv) } 
  end

  permissions :update? do
    it { should permit(usera, conv) } 
  end

  permissions :destroy? do
    # LOL NO IDEA WHAT TO DO HERE
    it "should probably permit something sometimes?"
  end
end
