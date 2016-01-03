class ConversationsController < ApplicationController
  before_action :ensure_user
  def index
    @conversations = current_user
      .conversations
  end
end
