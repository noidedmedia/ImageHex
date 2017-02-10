class CommissionsDashboardController < ApplicationController
  before_action :ensure_user
  def index
    @presenter = CommissionsDashboardPresenter.new(current_user)
    @no_footer = true
  end
end
