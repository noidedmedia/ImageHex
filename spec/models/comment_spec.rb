require 'rails_helper'
RSpec.describe Comment, :type => :model do
  it "should require user to be set" do
    expect(FactoryGirl.build(:comment,
                             user: nil)).to_not be_valid
  end
  it "should touch images" do
    i = FactoryGirl.create(:image)
    expect{
      FactoryGirl.create(:comment,
                         commentable: i)
    }.to change{i.updated_at}
  end
  it "should commit sudoku when subject is deleted" do
    i = FactoryGirl.create(:image)
    c = FactoryGirl.create(:comment, commentable: i)
    expect(c.commentable).to eq(i)
    i.destroy
    expect(Comment.where(id: c).first).to eq(nil)
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
    }.to change{Notification.count}.by(2) # also generates an image reply
  end
  it "makes a notification when mentioning a user" do
    u = FactoryGirl.create(:user)
    comment_str = "@#{u.name}"
    expect{
      FactoryGirl.create(:comment, body: comment_str)
    }.to change{Notification.count}.by(2) # also generates an image reply
  end

end
