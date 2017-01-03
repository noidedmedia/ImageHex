require 'rails_helper'

RSpec.describe Order::ReferenceGroup, type: :model do
  describe "validation" do
    it { should validate_presence_of(:description) }
  end
end
