class TagGroupsController < ApplicationController
  before_filter :ensure_user, except: :show
  before_filter :get_image
  def new
    @tag_group = TagGroup.new
  end

  def create
    @tag_group = TagGroup.create(tag_group_params)
    if @tag_group.save
      redirect_to @image
    else
      flash[:errors] = @tag_group.errors
      render 'new'
    end
  end

  def edit
    @tag_group = TagGroup.find(params[:id])
  end

  def update
    @tag_group = TagGroup.find(params[:id])
    if @tag_group.update(tag_group_params)
      redirect_to @image
    else
      flash[:erorrs] = @tag_group.errors
      render 'edit'
    end
  end
  protected
  def tag_group_params
    params.require(:tag_group)
      .permit(:tag_group_string)
      .merge(image_id: params[:image_id]) # Add in the image id automatically
  end
  def get_image
    @image = Image.find(params[:image_id])
  end
end
