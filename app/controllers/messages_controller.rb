class MessagesController < ApplicationController
  include Pundit
  before_action :ensure_user
  before_action :set_conversation, only: [:new, :create, :index]
  def index
    @messages = @conversation.messages
      .with_read_status_for(current_user)
      .order(created_at: :desc)
      .paginate(page: page, per_page: per_page)
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

end
