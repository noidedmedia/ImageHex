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
  json.partial! "images/list", images: @favorites
end

json.subscribed_artists @user.subscribed_artists,
  partial: "users/stub", as: :user

json.subscribers @user.subscribers,
  partial: "users/stub", as: :user


json.collections @collections, partial: "collections/stub", as: :c
json.bio @user.description
