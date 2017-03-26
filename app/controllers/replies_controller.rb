class RepliesController < ApplicationController
  before_action :get_parent
  before_action :get_reply, only: [:show, :edit, :update, :destroy]
  include Pundit

  def index
    puts @parent
    @replies = @parent.replies
      .order(created_at: :asc)
      .paginate(page: page, per_page: 60)
    respond_to do |format|
      format.json
    end
  end

  def new
    @reply = @parent.replies.build
    authorize @reply
  end

  def create
    @reply = parent.build(:reply_params)
    authorize @reply
    respond_to do |format|
      if @reply.save
        format.html { redirect_to @parent, notice: "Reply created!" }
        format.json { render 'show' }
      else
        format.html do
          flash[:warning] = "Could not save!"
          render 'new'
        end
        format.json { render @reply.errors, status: 401 }
      end
    end
  end

  def update
    respond_to do |format|
      if @reply.update(reply_params)
        format.html { redirect_to @parent, notice: "reply updated" }
        format.html { render 'show' }
      else
        format.html do
          flash[:warning] = "reply could not update"
          render 'edit'
        end
        format.json { render @reply.errors, status: 401 }
      end
    end
  end
    

  private
  def get_parent
    @parent = if params.has_key?("note_id")
                Note.friendly.find(params[:note_id])
              else
                nil
              end
  end

  def get_reply
    @reply = @parent.replies.find(params[:id])
  end

  def note_params
    params.require(:reply)
      .permit(:body)
      .merge(user_id: current_user.id)
  end
end
