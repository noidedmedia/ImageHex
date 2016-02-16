# frozen_string_literal: true
json.extract! subject, :description, :id
json.tags subject.tags do |tag|
  json.extract! tag, :name, :id, :description, :slug
end

json.references subject.references do |reference|
  json.extract! reference, :id
  json.url reference.file.url
end
