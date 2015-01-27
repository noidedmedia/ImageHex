class ImagesController < ApplicationController
  # Load the image via our id
  before_action :load_image, only: [:favorite, :created, :update, :edit, :destroy, :show]
  # Ensure a user is logged in. Defined in the application controller
  before_action :ensure_user, only: [:new, :create, :update, :edit, :destroy]

  ##
  # Current user has created this image
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
  def search
    @images = Image.search(params[:query]).paginate(page: page, per_page: per_page)
  end

  def new
    @image = Image.new
  end

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

  def update
  end

  def edit
  end

  def destroy
  end

  def index
    puts params
    @images = Image.paginate(page: page, per_page: per_page).order('created_at DESC')
  end

  def show
    @image = Image.find(params[:id])
  end
  ##
  # Put this image in a users collection
  def add
    c = Collection.find(params[:collection])
    ##
    # If the current usn't doesn't curate this colletion, they cannot
    # add images to it
    if ! c.curated?(current_user)
      flash[:error] = "You cannot add images to a collection you do not own."
      redirect_to Image.find(params[:id]) and return
    end
    c.images << Image.find(params[:id])
    redirect_to Image.find(params[:id])
  end
  protected
  # Load the image with the current id into params[:image]
  def load_image
    @image = Image.find(params[:id])
  end
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

end
