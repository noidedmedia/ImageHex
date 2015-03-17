class AddUserpagesToUsersWithoutThem < ActiveRecord::Migration
  def change
  end

  def data
    User.all.find_each do |user|
      unless user.user_page
        UserPage.create!(user: user,
                         markdown: "##{user.name} hasn't set this up")
      end
    end
  end
end
