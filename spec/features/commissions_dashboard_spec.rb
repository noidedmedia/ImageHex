require 'rails_helper'

RSpec.feature "commisions dashboard", type: :feature do
  include_context "when signed in" do
    let(:our_open_listing) { create(:open_listing, user: @user) }
    let(:our_closed_listing) { create(:listing, user: @user) }

    feature "viewing open listings" do
      scenario "without an open listing", js: true do
        visit commissions_dashboard_index_path
        expect(page).to_not have_css(".dashboard-item")
      end
    end
  end
end
