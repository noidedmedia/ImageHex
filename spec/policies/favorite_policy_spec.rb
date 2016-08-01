require 'rails_helper'

RSpec.describe FavoritePolicy do

  let(:user) { create(:user) }

  subject { described_class }

  

  permissions :create? do
  end



  permissions :destroy? do
  end
end
