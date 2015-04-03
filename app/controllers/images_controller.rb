
##
# As the name implies, this contorller handles all actions for images.
class ImagesController < ApplicationController
  # Load the image via our id
  before_action :load_image, only: [:comment, :favorite, :created, :update, :edit, :destroy, :show]
  # Ensure a user is logged in. Defined in the application controller
  before_action :ensure_user, only: [:unfavorite, :favorite, :created, :new, :create, :update, :edit, :destroy, :report, :comment]
  ##
  # Remove an image from the current users' favorites.
  # The image's id must be in params[:id]. The request must be a DELETE.
  # The user must be logged in.
  def unfavorite
    col = current_user.favorites
    image = Image.find(params[:id])
    result = col.images.delete(image)
    render json: result
  end

  ##
  # Create a new comment on the image in params[:id]
  # Redirects to the image if the comment is invalid.
  # Must be a POST request.
  # User must be logged in.
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
  # The current user adds the image to his "Created" collection,
  # which means he or she was involved in the creation of the image.
  # Image must be in params[:id]. User must be logged in.
  def created
    current_user.created! @image
    redirect_to(@image)
  end

  ##
  # User adds the image to their favorites collection.
  # Image must be in params[:id], user must be logged in.
  def favorite
    current_user.favorite! @image
    redirect_to(@image)
  end

  ##
  # Find images via the Image#search method.
  # Query should be in params[:query].
  def search
    @images = Image.search(params[:query])
    @images = @images.paginate(page: page, per_page: per_page) if @images
  end

  ##
  # Page to begin uploading a new image.
  # User must be logged in.
  # Sets the following variables:
  # @image:: A new image object, used to build the form.
  def new
    @image = Image.new
  end

  ##
  # Report an image that is unsuitable for ImageHex.
  # Image should be in params[:id]. User must be logged in.
  def report
    @image = Image.find(params[:id])
    @report = Report.new(report_params)
    @report.reportable = @image
    if @report.save
      redirect_to @image
    else
      flash[:error] = @report.errors.full_messages.join(", ")
      redirect_to @image
    end
  end

  ##
  # POST to create a new image. User must be logged in.
  #
  # If image is invalid, will redirect to the new action with errors set in
  # flash[:warning]
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
  # Sets the following varaibles:
  # @images:: the paginated list of images.
  def index
    @images = Image.paginate(page: page, per_page: per_page).order('created_at DESC')
  end

  ##
  # Show a image.
  # Sets the following variables:
  # @image:: The image being shown
  # @groups:: Tag groups on the image. Should be refactored out at some point.
  def show
    @groups = TagGroup.where(image: @image).includes(:tags)
  end
  
  protected
  # Load the image with params[:id] into @image.
  # should be refactored out.
  def load_image
    @image = Image.find(params[:id])
  end

  ##
  # Protected parameters for the image.
  #
  def image_params
    params.require(:image)
      .permit(:f, :license, :medium, :replies_to_inbox) # Attributes the user adds
      .merge(user_id: current_user.id) # We add the user id
  end


  ##
  # Parameters for our report
  def report_params
    params.require(:report)
      .permit(:severity, :message)
      .merge(user_id: current_user.id)
  end

  ##
  # Parameters for a comment
  def comment_params
    params.require(:comment)
      .permit(:body)
      .merge(user_id: current_user.id)
      .merge(commentable: @image)
  end
end
