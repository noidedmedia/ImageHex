# frozen_string_literal: true
class ConversationsController < ApplicationController
  before_action :ensure_user
  rescue_from Conversation::UserNotInConversation, with: :unauthorized
  def index
    @conversations = current_user
      .conversations
  end

  def read
    @conversation = Conversation.find(params[:id])
    @conversation.mark_read!(current_user)
    respond_to do |format|
      format.html { redirect_to @conversation, notice: :success }
      format.json { render json: true }
    end
  end
end
