require 'spec_helper'
##
# To upload pictures
include ActionDispatch::TestProcess
describe Image do
  # Images have many tag groups
  it {should have_many(:tag_groups)}
  # Images need to belong to a user 
  it {should belong_to :user}
  it {should validate_presence_of(:user)}
  # Images must have both mediums:
  it {should validate_presence_of(:medium)}
  it {should validate_presence_of(:license)}

  # Validators for the file
  it {should have_attached_file :f}
  it {should validate_attachment_presence(:f)}
  # Make sure the file is an image
  it {should validate_attachment_content_type(:f)
      .allowing("image/png", "image/gif", "image/jpeg", "image/bmp")
      .rejecting("text/plain", "text/xml", "audio/mp3")}
  it "allows selection by reports" do
    image = FactoryGirl.create(:image)
    # We make a non-reported image for testing purposes
    image2 = FactoryGirl.create(:image)
    FactoryGirl.create(:report, reportable:  image)
    expect(Image.by_reports).to eq([image])
  end

end

