class MessagesController < ApplicationController
  include Pundit
  before_action :ensure_user
  before_action :set_conversation, only: [:new, :create, :index]
  def index
    @messages = @conversation.messages
      .with_read_status_for(current_user)
      .order(created_at: :desc)
      .limit(20)
    if params[:before]
      @messages = @messages.where("messages.created_at < ?", params[:before])
    end
  end

  def by_time
    @messages = Message.with_read_status_for(current_user)
    if c = Time.parse(params[:after])
      @messages = @messages.posted_since(c)
    end
    render 'index'
  end

  def create
    @message = @conversation.messages.build(message_params)
    respond_to do |format|
      if @message.save
        format.html { redirect_to @message }
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
