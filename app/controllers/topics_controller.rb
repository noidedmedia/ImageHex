class TopicsController < ApplicationController
  include TopicsHelper
  before_filter :ensure_user, except: [:index, :show]
  before_filter :set_parent
  before_filter :set_topic, only: [:show, :edit, :update, :destroy]

  def show
    @topic = @parent.topics.friendly.find(params[:id])
    @replies = @topic.replies
      .order(created_at: :asc)
      .includes(:user)
      .paginate(page: page, per_page: per_page)
  end

  def index
    @topics = @parent.topics.order(updated_at: :desc)
  end

  def new
    @topic = @parent.topics.build
    @reply = @topic.replies.build
  end

  def create
    @topic = @parent.topics.build(topic_params)
    @reply = @topic.replies.build(reply_params)
    respond_to do |format|
      if @topic.save
        format.html { redirect_to [@parent, @topic] }
        format.json { render 'show' }
      else
        format.html do
          flash[:warning] = "Could not save!"
          render 'new'
        end
        format.json { render json: @topic.errors, status: 401 }
      end
    end
  end

  def edit
  end

  def update
  end

  private
  def set_parent
    @parent = if params[:tag_id]
                Tag.friendly.find(params[:tag_id])
              else
                raise ActiveRecord::RecordNotFound
              end
  end

  def set_topic
    @topic = @parent.topics.friendly.find(params[:id])
  end

  def topic_params
    params.require(:topic).permit(:title).merge(user: current_user)
  end

  def reply_params
    params.require(:reply).permit(:body).merge(user: current_user)
  end
end
