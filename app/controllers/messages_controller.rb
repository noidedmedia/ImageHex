class MessagesController < ApplicationController
  include Pundit
  before_action :ensure_user
  before_action :set_conversation, only: [:new, :create, :index]
  def index
  end

  protected
  def set_conversation
    @conversation = Conversation.find(params[:conversation_id])
  end

end
