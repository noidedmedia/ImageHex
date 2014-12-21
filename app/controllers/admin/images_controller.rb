class Admin::ImagesController < Admin::AdminController
  def index
    @images = Image.by_reports
  end

  def destroy
    @image = Image.find(params[:id]).delete
    redirect_to "/admin/images"
  end
  ##
  # Remove all reports on the image.
  def absolve
    @image = Image.find(params[:id])
    @image.reports.map(&:delete)
    redirect_to "/admin/images"
  end

end
