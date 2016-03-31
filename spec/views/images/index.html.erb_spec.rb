# frozen_string_literal: true
require 'spec_helper'

describe "images/index.html.erb" do
  let(:images) do
    10.times.map { create(:image) } 
  end
  it "displays all the images" do
    assign(:images, images.paginate(per_page: 10))
    render
    expect(rendered).to have_selector(".image-gallery-item",
                                      count: 10)
  end
end
