require 'spec_helper'
##
# To upload pictures
include ActionDispatch::TestProcess
describe Image do

  # Images need to belong to a user 
  it {should belong_to :user}
  it {should validate_presence_of(:user)}
  # Validators for the file
  it {should have_attached_file :f}
  it {should validate_attachment_presence(:f)}
  # Make sure the file is an image
  it {should validate_attachment_content_type(:f)
    .allowing("image/png", "image/gif", "image/jpeg", "image/bmp")
    .rejecting("text/plain", "text/xml", "audio/mp3") }

end
