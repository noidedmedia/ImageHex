class DisputesController < ApplicationController
  include Pundit
  before_filter :ensure_user
  def index
    @disputes = Dispute.all.unresolved
    raise Pundit::NotAuthorizedError unless current_user.admin?
  end

  def new
    attrs = {
      commission_offer_id: params[:commission_offer_id]
    }
    @dispute = Dispute.new(attrs)
    authorize @dispute
  end
end
