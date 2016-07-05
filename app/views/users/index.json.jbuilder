# frozen_string_literal: true
json.users @users do |c|
  json.extract! c, :name, :id, :slug, :description
  json.images c.creations.take(5), partial: "images/stub", as: :image
end
json.page @users.current_page
json.total_pages @users.total_pages
