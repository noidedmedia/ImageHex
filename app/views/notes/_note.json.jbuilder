json.extract! note,
  :user_id,
  :id,
  :slug,
  :title,
  :body,
  :created_at,
  :updated_at

json.html_body markdown_parse(note.body)

json.user do 
  json.extract! note.user,
    :name,
    :id,
    :slug

  json.avatar_path path_to_image(note.user.avatar_img_thumb)
end
