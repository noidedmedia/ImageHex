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

      scenario "they favorite an image", js: true do
        visit image_path(@image)

        expect do
          find("#img-action-favorite", visible: false).click
        end.to change{Favorite.count}.by(1)

        expect(current_path).to eq(image_path(@image))
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

    feature "reporting" do
      scenario "they report an image", js: true do
        visit image_path(@image)

        expect(page).to have_css("#img-action-report")

        find("#img-action-report").click

        expect(page).to have_css("#img-action-report-tooltip.active")

        within("#report-form") do
          choose("report_reason_illegal_content", visible: false)
          expect do
            click_button("Report")
          end.to change{ImageReport.count}.by(1)
        end
      end
    end
  end # when signed in
end
