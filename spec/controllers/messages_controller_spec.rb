require 'rails_helper'

RSpec.describe MessagesController, type: :controller do
  include Devise::TestHelpers
  context "when logged in" do
    before(:each) do 
      @user = FactoryGirl.create(:user)
      @user.confirm
      sign_in @user
    end

    let(:user_b){FactoryGirl.create(:user)}
    let(:conv){FactoryGirl.create(:conversation,
                                  user_ids: [@user.id, user_b.id])}
    describe "POST #create" do
      let(:msg_params){
        { body: "This is a test" }
      }
      it "makes a new message" do
        expect{
          post :create, conversation_id: conv.id, message: msg_params
        }.to change{conv.messages.count}.by(1)
      end
    end
    describe "GET #index" do
      it "works" do
        get :index, conversation_id: conv.id
        expect(response).to be_success
      end
    end
    describe "GET #show" do
      let(:msg){FactoryGirl.create(:message,
                                   conversation: conv)}
      it "works" do
        get :show, conversation_id: conv.id, id: msg.id
        expect(response).to be_success
      end
    end
  end
end
