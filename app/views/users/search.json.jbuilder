json.users @users do |user|
  json.extract! user,
    :name,
    :id,
    :slug

  json.avatar_img_thumb path_to_image(user.avatar_img_thumb)

end
json.page @users.current_page
json.total_pages @users.total_pages
