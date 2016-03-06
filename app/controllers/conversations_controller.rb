# frozen_string_literal: true
class ConversationsController < ApplicationController
  include Pundit
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

  def edit
    @conversation = Conversation.find(params[:id])
    authorize @conversation
  end

  def update
    @conversation = Conversation.find(params[:id])
    authorize @conversation
    respond_to do |format|
      if @conversation.update(conversation_params)
        format.html { redirect_to @conversation }
        format.json { render 'show' }
      else
        format.html { render 'edit' }
        format.json { render @conversation.errors, status: 422 }
      end
    end
  end

  def conversation_params
    params.require(:conversation)
      .permit(:name)
  end
end
