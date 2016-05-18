require 'rails_helper'

RSpec.describe OrderPolicy do

  let(:user) { create(:user) }

  subject { described_class }

  permissions :show? do
  end

  permissions :create? do
  end

  permissions :update? do
  end

  permissions :destroy? do
  end
end
