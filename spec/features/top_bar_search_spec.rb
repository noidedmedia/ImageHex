require 'spec_helper'

feature 'Top Bar Search', feature: true do
  before(:each) do
    @tag1 = create(:tag, name: "winter")
    @tag2 = create(:tag, name: "wyven")
    @tag3 = create(:tag, name: "foo")
  end
  feature "tag suggestions" do
    scenario "the user types a single letter", js: true do
      visit root_path
      fill_in_search_input
      expect(page).to have_css(".tag-group-editor-tags-suggestions")
      expect(page).to have_css(".tag-group-tag-suggestion", count: 2)
    end

    scenario "the user clicks a suggestion", js: true do
      visit root_path
      fill_in_search_input
      click_suggestion
      expect(page).to have_css(".tag-box-added-tag")
    end

    def fill_in_search_input(input = "w")
      fill_in 'search-input', with: 'w'
    end

    def click_suggestion(sug = "winter")
      find(".tag-group-tag-suggestion span", text: sug).click
    end
  end
end
