class CommissionsDashboardController < ApplicationController
  before_action :ensure_user
  def index
    @presenter = CommissionsPresenter.new(current_user)
    @no_footer = true
  end
end
