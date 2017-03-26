class TopicsController < ApplicationController
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


  def create
    @topic = @parent.topics.build(topic_params)
    @reply = @topic.replies.build(reply_params)
  end

  def new
    @topic = @parent.topics.build
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
    params.require(:tag_topic_reply)
  end
end
