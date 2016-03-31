# frozen_string_literal: true
json.extract! background,
              :id,
              :description

json.references background.references do |reference|
  json.extract! reference, :id
  json.url reference.file.url
end
