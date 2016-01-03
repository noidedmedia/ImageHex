json.extract! @messages, :current_page, :per_page, :total_entries
json.messages @messages, partial: "message", as: :message
