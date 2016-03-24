# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Message, type: :model do
  describe "scopes" do
    describe ".created_after" do
      it "gives messages posted since a certain date" do
        b = create(:message)
        a = create(:message)
        expect(Message.created_after(b.created_at)).to eq([a])
      end
    end
  end  
end
