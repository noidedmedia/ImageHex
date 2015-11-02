json.extract! @user, :name, :id, :created_at
json.uploads do
  json.partial! "images/list", images: @uploads
end

json.creations do
  json.partial! "collections/stub", collection: @user.creations
end
json.favorites do
  json.partial! "collections/stub", collection: @user.favorites
end

json.collections @collections, partial: "collections/stub", as: :collection
json.bio @user.user_page.body
json.elsewhere @user.user_page.elsewhere
