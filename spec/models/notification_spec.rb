require 'rails_helper'

RSpec.describe Notification, :type => :model do
  it {should validate_presence_of(:user)}
  it {should validate_presence_of(:subject)}
  it {should validate_presence_of(:message)}
  describe "deletion" do
    it "dies when the subject deletes itself" do
      i = FactoryGirl.create(:image)
      n = FactoryGirl.create(:notification, subject: i)
      expect(n.subject).to eq(i)
      i.destroy
      expect(Image.where(id: i.id).first).to eq(nil)
      expect(Notification.where(id: n.id).first).to eq(nil)
    end
  end
end
