# frozen_string_literal: true
require 'spec_helper'

describe "images/index.html.erb" do
  let(:images) do
    10.times.map { create(:image) } 
  end
end
