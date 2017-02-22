class AddFingerprintToReferenceImages < ActiveRecord::Migration[5.0]
  def change
    add_column :order_group_images,
      :img_fingerprint,
      :string
  end
end
