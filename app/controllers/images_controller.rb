class ImagesController < ApplicationController
  # Load the image via our id
  before_action :load_image, only: [:comment, :favorite, :created, :update, :edit, :destroy, :show]
  # Ensure a user is logged in. Defined in the application controller
  before_action :ensure_user, only: [:unfavorite, :favorite, :created, :new, :create, :update, :edit, :destroy, :report, :comment]
  def unfavorite
    col = current_user.favorites
    image = Image.find(params[:id])
    result = col.images.delete(image)
    render json: result
  end

  def comment
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to @image
    else
      flash[:errors] = @comment.errors.full_messages
      redirect_to @image
    end
  end
  ##
  # The current user alerts the site that an image was created by him.
  def created
    current_user.created! @image
    redirect_to(@image)
  end

  ##
  # Current user wishes to add this image to their favorites
  def favorite
    current_user.favorite! @image
    redirect_to(@image)
  end

  ##
  # Find images via the Image#search method.
  # Query should be in params[:query]
  def search
    @images = Image.search(params[:query]).paginate(page: page, per_page: per_page)
  end

  ##
  # Page to begin uploading a new image
  def new
    @image = Image.new
  end

  ##
  # Report an image that is unsuitable for ImageHex
  def report
    @image = Image.find(params[:id])
    @report = Report.new(report_params)
    @report.reportable = @image
    if @report.save
      redirect_to @image
    else
      flash[:error] = @report.errors.full_messages.join(", ")
      puts flash[:error]
      redirect_to @image
    end
  end

  ##
  # POST to create a new image.
  # If the params are invaldi, ti redirects to the new action
  def create
    @image = Image.new(image_params)
    if @image.save
      redirect_to @image
    else
      # If their image is incorrect, redirect_to the new page again.
      flash[:warning] = @image.errors.full_messages.join(', ')
      redirect_to action: :new
    end
  end

  ##
  # Modify an uploaded image with a PUT.
  # Currently does nothing.
  def update
  end

  ##
  # GET to acquire a page where you can edit an image.
  # Does nothing currently.
  def edit
  end

  ##
  # DELETE to remove an image.
  # Does nothing currently.
  def destroy
  end

  ##
  # Obtain all images, in order of uploading.
  # Paginated according to user preferences.
  def index
    @images = Image.paginate(page: page, per_page: per_page).order('created_at DESC')
  end

  def show
    @groups = @image.tag_groups.includes(:tags)
  end
  ##
  # Put this image in a users collection
  
  protected
  # Load the image with the current id into params[:image]
  def load_image
    @image = Image.find(params[:id])

  end

  ##
  # Protected parameters for the image.
  def image_params
    params.require(:image)
      .permit(:f, :license, :medium) # Attributes the user adds
      .merge(user_id: current_user.id) # We add the user id
  end


  ##
  # Parameters for our report
  def report_params
    params.require(:report)
      .permit(:severity, :message)
      .merge(user_id: current_user.id)
  end

  def comment_params
    params.require(:comment)
      .permit(:body)
      .merge(user_id: current_user.id)
      .merge(commentable: @image)
  end
end
