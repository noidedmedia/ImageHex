# frozen_string_literal: true
json.extract! @user, :name, :id, :created_at
json.avatar_url @user.avatar? ? @user.avatar(:medium) : nil
json.uploads do
  json.partial! "images/list", images: @uploads
end

json.creations do
  json.partial! "images/list", images: @creations
end

json.favorites do
  json.partial! "collections/stub", c: @user.favorites
end

json.collections @collections, partial: "collections/stub", as: :c
json.bio @user.description
