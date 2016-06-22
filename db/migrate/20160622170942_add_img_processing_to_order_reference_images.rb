class AddImgProcessingToOrderReferenceImages < ActiveRecord::Migration[5.0]
  def change
    add_column :order_reference_images, :img_processing, :boolean
  end
end
