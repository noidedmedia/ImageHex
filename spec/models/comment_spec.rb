require 'rails_helper'

RSpec.describe Comment, :type => :model do
  it "should require user to be set" do
    expect(FactoryGirl.build(:comment,
                             user: nil)).to_not be_valid
  end
  it "should require the commentable to be set" do
    expect(FactoryGirl.build(:comment,
                             commentable: nil)).to_not be_valid
  end
  it "should require the body to be set" do
    expect(FactoryGirl.build(:comment,
                             body: nil)).to_not be_valid
  end
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
