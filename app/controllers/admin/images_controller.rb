class Admin::ImagesController < Admin::AdminController
  def index
    @images = Image.by_reports
    @images.paginate(page: page, per_page: page)
  end

  def delete
    @image = Image.find(params[:id]).delete
  end
  ##
  # Remove all reports on the image.
  def absolve
    @image = Image.find(params[:id])
    @image.reports.map(&:delete)
  end

end
