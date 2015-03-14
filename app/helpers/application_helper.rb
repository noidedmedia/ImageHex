module ApplicationHelper
  def comment_path(comment)
    polymorphic_path(comment.commentable) + "##{comment.id}"
  end
end
