module ApplicationHelper
  ##
  # This allows us to get a "link" to a comment, which is really just a link
  # to the thing being commented on with the id of the comment appended with
  # a #
  def comment_path(comment)
    polymorphic_path(comment.commentable) + "##{comment.id}"
  end
end
