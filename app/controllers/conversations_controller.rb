# frozen_string_literal: true
class ConversationsController < ApplicationController
  before_action :ensure_user
  rescue_from Conversation::UserNotInConversation, with: :unauthorized

  def show
    @conversation = Conversation.find(params[:id])
  end

  ##
  # The HTML version of this generates an N+1 query to fetch messages.
  # We do this on purpose.
  # A bunch of small message fetches are probably better on our DB than
  # fetching all messages in all conversations for this user.
  def index
    @conversations = current_user
      .conversations
      .with_unread_status_for(current_user)
      .includes(:users)
      .uniq
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
