require 'rails_helper'

RSpec.describe ConversationsController, type: :controller do
  include Devise::TestHelpers
  context "when logged in" do
    before(:each) do
      @user = FactoryGirl.create(:user)
      sign_in @user
    end
    describe "POST #create" do
      let(:user_a){FactoryGirl.create(:user)}
      let(:conversation_params){ 
        { 
          user_ids: [@user.id, user_b.id],
          title: "test"
        }
      }
      it "creates a new conversation" do
        expect{
          post :create, conversation: conversation_params
        }.to change{Conversation.count}.by(1)
      end
      it "sets attributes properly" do
        post :create, conversation:  conversation_params
        c = Conversation.last
        expect(c.users).to contain_exactly(@user, user_b)
        expect(c.title).to eq("test")
      end
    end
  end
end
