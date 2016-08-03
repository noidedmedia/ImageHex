RSpec.feature "User creates a collection", type: :feature do
  include_context "when signed in" do
    scenario "the user sees the form" do
      visit new_collection_path

      expect(page).to have_css("#collection_description")

      fill_in "Title", with: "A Test Title"
      find("#collection_description").set("A Test Description")

      expect do
        click_button "Create collection"
      end.to change{Collection.count}.by(1)
      c = Collection.last
      expect(current_path).to eq(collection_path(c))
    end
  end

  context "when not logged in" do
    scenario "the nonregistered user visits the form" do
      visit new_collection_path

      expect(current_path).to eq("/accounts/sign_in")
    end
  end

end
