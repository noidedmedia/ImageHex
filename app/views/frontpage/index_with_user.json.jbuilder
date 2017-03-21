json.images @images do |img|
  json.extract! img,
    :reason,
    :reason_id,
    :reason_type,
    :id,
    :sort_created_at

  json.huge_url img.f(:huge)
  json.large_url img.f(:large)
  json.medium_url img.f(:medium)
  json.small_url img.f(:small)

  json.creators img.creators do |c|
    json.extract! c,
      :name,
      :id,
      :slug

    json.avatar_path path_to_image(c.avatar_img_thumb)
  end
end

json.notes @notes do |note|
  json.extract! note,
    :created_at,
    :body,
    :title

  json.html_body markdown_parse(note.body)

  json.user do
    json.partial! "users/stub", user: note.user
  end
end
