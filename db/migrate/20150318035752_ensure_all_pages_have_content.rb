class EnsureAllPagesHaveContent < ActiveRecord::Migration
  def data
    UserPage.all.find_each do |page|
      unless page.body?
        page.body = "#{page.user.name} hasn't set me up yet!"
        page.save
      end
    end
  end
end
