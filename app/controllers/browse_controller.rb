class BrowseController < ApplicationController
  def creators
    @creators = User.popular_creators
      .includes(:creations)
      .merge(Image.for_content(content_pref))
      .paginate(page: page, per_page: per_page)
  end
end
