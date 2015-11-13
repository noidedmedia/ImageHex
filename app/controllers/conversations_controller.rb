class ConversationsController < ApplicationController
  include Pundit
  before_action :ensure_user
  def create
    @conversation = Conversation.new(conversation_params)
    authorize @conversation
    respond_to do |format|
      if @conversation.save
        format.html { redirect_to @conversation }
        format.json { render 'show' } 
      else
        puts "errors: #{@conversation.errors.inspect}"
        format.html { flash[:error] = @conversation.errors; render 'new' }
        format.json { render json: @conversation.errors,
          status: :unprocessible_entity }
      end
    end
  end

  protected
  def conversation_params
    params.require(:conversation)
      .permit(:title,
              user_ids: [])
  end
end
