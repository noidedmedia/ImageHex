# frozen_string_literal: true
class MessagesController < ApplicationController
  include Pundit
  before_action :ensure_user
  before_action :set_conversation

  def index
    @messages = @conversation.messages
      .with_read_status_for(current_user)
      .order(created_at: :desc)
      .limit(20)
    if params[:after]
      @messages = @messages.created_after(Time.at(params[:after].to_f))
    end
    if params[:before]
      @messages = @messages.created_before(Time.at(params[:before].to_f))
    end
    @conversation.mark_read! current_user
  end

  def new
    @message = @conversation.messages.new
  end

  def create
    @message = @conversation.messages.build(message_params)
    respond_to do |format|
      if @message.save
        # Assume the user had read this conversation if htey are chatting in it
        @conversation.mark_read! current_user
        format.html { head :ok }
        format.json { render 'show' }
      else
        format.html { render 'new', errors: @message.errors }
        format.json { render 'show', status: :unproccessible_entity }
      end
    end
  end

  def unread
    @messages = Message.unread_for(current_user).includes(:user)
  end

  protected

  def set_conversation
    @conversation = Conversation.find(params[:conversation_id])
    # Gotta do this manually, sadly
    unless ConversationPolicy.new(current_user, @conversation).show?
      raise Punit::NotAuthorizedError
    end
  end

  def message_params
    params.require(:message)
      .permit(:body)
      .merge(user_id: current_user.id)
  end
end
