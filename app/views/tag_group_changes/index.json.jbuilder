# frozen_string_literal: true
json.partial! "tag_group_changes/change",
              collection: @changes,
              as: :change
