require 'rails_helper'

RSpec.describe ConversationsController, type: :controller do
  context "when logged in" do
    describe "POST #create" do
      let(:user_a){FactoryGirl.create(:user)}
      let(:user_b){FactoryGirl.create(:user)}
      it "creates a new conversation" do
      end
    end
  end
end
