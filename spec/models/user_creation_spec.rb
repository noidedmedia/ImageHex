require 'rails_helper'

RSpec.describe UserCreation, type: :model do
  it "touches images" do
    i = FactoryGirl.create(:image)
    expect do
      i.user.creations << i
    end.to change { i.updated_at }
  end
end
