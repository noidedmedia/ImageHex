require 'rails_helper'

RSpec.feature "Image show page", type: :feature do
  before(:each) do
    @image = create(:image)
  end

  include_context "when signed in" do
    feature "favoriting" do
      scenario "they see the favorites button", js: true do
        visit image_path(@image)

        expect(page).to have_css("#img-action-favorite")
      end
    end

    feature "collections" do

      scenario "they try to add an image to collections", js: true do
        collection = create(:collection, curators: [@user])
        visit image_path(@image)
        find("#img-action-collection").click

        expect(find("#image-collection-list")).to have_content(collection.name)

        find("#image-collection-list").find(".collection-add-list-item").click

        expect(find("#image-collection-list")
               .find(".contains-image")).to have_content(collection.name)

        find("#image-collection-list").find(".contains-image").click
      end
    end

    feature "sharing" do
      scenario "they click the share button", js: true do
        visit image_path(@image)

        expect(page).to have_css("#img-action-report")
        expect(page).to_not have_css("#img-action-share-tooltip")

        find("#img-action-share").click

        expect(page).to have_css("#img-action-share-tooltip")
      end
    end
  end # when signed in
end
