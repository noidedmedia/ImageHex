require 'rails_helper'

RSpec.feature "Image Uploads", type: :feature do
  include_context "when signed in" do
    scenario "the user uploads an image with no content ratings" do
      visit new_image_path
      attach_file "image[f]", test_image_path
      select "CC-BY"
      select "Digital paint"
      fill_in "image[description]", with: "this is a test"

      expect { click_button("Submit") }.to change{Image.count}.by(1)
      i = Image.last
      expect(current_path).to eq(image_path(i))
      expect(i.license).to eq("cc_by")
      expect(i.medium).to eq("digital_paint")
    end
  end
end
