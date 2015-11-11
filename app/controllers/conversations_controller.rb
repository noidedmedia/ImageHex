class ConversationsController < ApplicationController
  include Pundit
  before_action :ensure_user

  protected
  def conversation_params
    params.require(:conversation)
      .permit(:user_ids,
              :title)
  end
end
