# frozen_string_literal: true
json.extract! user, :name, :id, :slug
json.avatar_path path_to_image(user.avatar_img_thumb)
