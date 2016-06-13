json.images @images do |img|
  json.extract! img,
    :reason,
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
