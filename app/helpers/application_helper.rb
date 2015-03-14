module ApplicationHelper
  def comment_path(comment)
    polymorphic_path(comment.subject) + "##{comment.id}"
  end
end
