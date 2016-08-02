# frozen_string_literal: true
json.extract! c, :name, :id
json.url polymorphic_path(c, format: :json)
