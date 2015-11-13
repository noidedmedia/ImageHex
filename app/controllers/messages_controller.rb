class MessagesController < ApplicationController
  before_action :ensure_user
  before_action :load_conversation
  include Pundit
  def index
    @messages = if t = params[:view_after].try(:to_time)
                  @conversation.messages.where("created_at > ?", t)
                else
                  @conversation.messages
                end
  end

  def show
    @message = @conversation.messages.find(params[:id])
  end

  def new
    @message = @conversation.messages.build
  end

  def create
    @message = @conversation.messages.build(message_params)
    authorize @message
    respond_to do |fmt|
      if @message.save
        fmt.html { redirect_to @conversation }
        fmt.json { render 'show' }
      else
        fmt.html {
          flash[:error] = @message.errors
          redirect_to action: 'new'
        }
        fmt.json { render json: @message.errors, status: :unproccessible_entity}
      end
    end
  end
  protected
  def load_conversation
    @conversation = Conversation.find(params[:conversation_id])
    # Only allow any action if we can see the conversation
    unless ConversationPolicy.new(current_user, @conversation).show?
      raise Pundit::NotAuthorizedPolicy
    end
  end

  def message_params
    params.require(:message)
      .permit(:body)
      .merge(conversation: @conversation,
             user: @current_user)
  end
end
