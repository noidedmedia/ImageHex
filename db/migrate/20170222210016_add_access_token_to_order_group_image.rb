class AddAccessTokenToOrderGroupImage < ActiveRecord::Migration[5.0]
  def change
    add_column :order_group_images,
      :access_token,
      :string
  end
end
