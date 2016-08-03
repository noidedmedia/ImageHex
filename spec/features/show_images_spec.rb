require 'rails_helper'

RSpec.feature "Image show page", type: :feature do
  before(:each) do
    @image = create(:image)
  end

  include_context "when signed in" do

    scenario "they see the favorites button", driver: :poltergeist_silent do
      visit image_path(@image)

      expect(page).to have_css("#img-action-favorite")
    end

    scenario "they favorite an image", driver: :poltergeist_silent do
      visit image_path(@image)

      expect do
        find("#img-action-favorite", visible: false).click
      end.to change{Favorite.count}.by(1)

      expect(current_path).to eq(image_path(@image))
    end
  end


end
