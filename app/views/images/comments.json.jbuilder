json.comments @comments do |comment|
  json.extract! comment,
    :id, :created_at
  json.html_body markdown_parse(comment.body)
  json.body comment.body
  json.user comment.user, partial: "users/stub", as: :user
end

json.page @comments.current_page
json.total_pages @comments.total_pages
