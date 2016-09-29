class CommissionsDashboardController < ApplicationController
  before_action :ensure_user
  def index
    @presenter = CommissionsPresenter.new(current_user)
  end
end
