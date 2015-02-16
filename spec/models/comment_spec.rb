require 'rails_helper'

RSpec.describe Comment, :type => :model do
  it {should validate_presence_of(:user)}
  it {should validate_presence_of(:commentable)}
  it {should validate_presence_of(:body)}
  it "makes a notification when replying" do
    c = FactoryGirl.create(:comment)
    expect{
      FactoryGirl.create(:comment, body: ">>#{c.id}:")
    }.to change{Notification.count}.by(1)
  end
  it "makes a notification when mentioning a user" do
    u = FactoryGirl.create(:user)
    comment_str = "@#{u.name}"
    expect{
      FactoryGirl.create(:comment, body: comment_str)
    }.to change{Notification.count}.by(1)
  end

end
