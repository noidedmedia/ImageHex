##
# Helpers used universally throughout ImageHex
module ApplicationHelper

  def price(num)
    number_to_currency(num / 100)
  end
  def frontpage_reason_path img
    return "" unless id = img.try(:reason_id)
    case img.try(:reason_type)
    when "user"
      "/users/" + id.to_s
    when "collection"
      "/collections/" + id.to_s
    end
  end
  def user_path user
    "/@" + user.slug.to_s
  end

  def notification_path note
    if note[:type] == :comment
      if note[:commentable_type] == :image
        "/images/" + note[:commentable_id]
      end
    end
  end

  def comment_url comment
    polymorphic_url(comment.commentable) + "#" + comment.id.to_s
  end

  def markdown_parse(str)
    return unless str
    options = {
      filter_html: true,
      hard_wrap: true,
      link_attributes: {rel: "nofollow", target: "_blank"},
      no_styles: true,
      no_images: false,
      with_toc_data: true,
      no_intra_emphasis: true,
      safe_links_only: true,
      lax_spacing: true
    }
    extensions = {
      autolink: true,
      superscript: true
    }
    renderer = Redcarpet::Render::HTML.new(options)
    markdown = Redcarpet::Markdown.new(renderer, extensions)
    markdown.render(str).html_safe
  end

  def pretty_time(t)
    t.strftime("%l:%M %p %B %d, %Y")
  end
  ##
  # This allows us to get a "link" to a comment, which is really just a link
  # to the thing being commented on with the id of the comment appended to the
  # URL as an anchor link.
  def comment_path(comment)
    polymorphic_path(comment.commentable) + "##{comment.id}" if comment.commentable
  end

  ##
  # Used on the About, People, and Contact pages to add a "current"
  # class to the tab link if the page linked is the current page.
  def current(path)
    "current" if current_page?(path)
  end

  ##
  # Used for page's HTML titles.
  # http://stackoverflow.com/a/3841549
  def title(page_title)
    content_for(:title) { page_title }
  end
end
