# frozen_string_literal: true
class ConversationsController < ApplicationController
  include Pundit
  before_action :ensure_user
  rescue_from Conversation::UserNotInConversation, with: :unauthorized

  def show
  end

  ##
  # The HTML version of this generates an N+1 query to fetch messages.
  # We do this on purpose.
  # A bunch of small message fetches are probably better on our DB than
  # fetching all messages in all conversations for this user.
  def index
    @conversations = current_user
      .conversations
      .preload(conversation_users: :user)
      .with_unread_status_for(current_user)
    respond_to do |format|
      format.json
    end

  end

  def read
    @conversation = Conversation.find(params[:id])
    @conversation.mark_read!(current_user)
    respond_to do |format|
      format.json { render json: @conversation.last_read_for(current_user) }
    end
  end

  def edit
    @conversation = Conversation.find(params[:id])
    authorize @conversation
  end

  def new
    @conversation = Conversation.new
    authorize @conversation
  end

  def create
    @conversation = Conversation.new(conversation_params)
    authorize @conversation

    respond_to do |format|
      if @conversation.save
        format.json { render 'show' }
        format.html { redirect_to(root_path, notice: "Created!") }
      else
        format.json { render json: @conversation.errors, status: 401 }
        format.html { render 'new' }
      end
    end
  end

  def update
    @conversation = Conversation.find(params[:id])
    authorize @conversation
    respond_to do |format|
      if @conversation.update(conversation_edit_params)
        format.html { redirect_to @conversation }
        format.json { render 'show' }
      else
        format.html { render 'edit' }
        format.json { render @conversation.errors, status: 422 }
      end
    end
  end

  protected
  def conversation_edit_params
    params.require(:conversation)
      .permit(:name)
  end

  def conversation_params
    params.require(:conversation)
      .permit(:name)
      .merge(user_ids: conversation_user_ids)
  end

  def conversation_user_ids
    ary = params[:conversation][:user_ids]
    ary.append(current_user.id)
  end
end
