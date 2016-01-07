class AddSubscribedToNewsletterToUsers < ActiveRecord::Migration
  def change
    add_column :users, :subscribed_to_newsletter,
      :boolean,
      null: false,
      default: false
  end
end
