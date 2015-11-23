class BrowseController < ApplicationController
  def creators
    @creators = User.popular_creators
      .preload(:creations)
      .merge(Image.for_content(content_pref))
      .paginate(page: page, per_page: per_page)
  end
  def images
    @images = Image.by_popularity
      .paginate(page: page, per_page: per_page)
      .for_content(content_pref)
    render 'images/index'
  end
end
