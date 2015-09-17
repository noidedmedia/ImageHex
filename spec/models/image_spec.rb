require 'spec_helper'
##
# To upload pictures
include ActionDispatch::TestProcess
describe Image do
  describe "content validation" do
    let(:sex){FactoryGirl.create(:image,
                                 nsfw_sexuality: true)}
    let(:nude){FactoryGirl.create(:image,
                                  nsfw_nudity: true)}
    let(:lang){FactoryGirl.create(:image, 
                                  nsfw_language: true)}
    let(:gore){FactoryGirl.create(:image,
                                  nsfw_gore: true)}
    let(:collec){Image.where(id: [sex, nude, lang, gore].map(&:id))}
    describe "content preference" do
      let(:pref){ {"nsfw_gore" => true,
        "nsfw_sexuality" => true} }
      it "follows the content preference" do
        expect(Image.for_content(pref)).to contain_exactly(gore, sex)
      end
    end
    describe "scopes" do
      it "has a scope for without nudity" do
        expect(collec.without_nudity).to contain_exactly(sex, gore, lang)
      end
      it "has a scope for without sexuality" do
        expect(collec.without_sex).to contain_exactly(nude, lang, gore)
      end
      it "has a scope for without language" do
        expect(collec.without_language).to contain_exactly(nude, gore, sex)
      end
      it "has a scope for without gore" do
        expect(collec.without_gore).to contain_exactly(nude, lang, sex)
      end
      it "has a scope for completely safe" do
        expect(collec.completely_safe.size).to eq(0)
      end
      it "has a scope that removes everything but language" do
        expect(collec.mostly_safe).to eq([lang])
      end
    end
  end
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

  # Image in relation to collections
  it {should have_many(:collection_images)}
  it {should have_many(:collections).through(:collection_images)}

end

