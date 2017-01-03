class ChangeOrderReferenceToOrderReferenceGroup < ActiveRecord::Migration[5.0]
  def change
    rename_table :order_references,
      :order_reference_groups
    rename_table :order_reference_tags,
      :order_reference_group_tags
    rename_column :order_reference_group_tags,
      :order_reference_id,
      :order_reference_group_id
    rename_table :order_reference_images,
      :order_reference_group_images
    rename_column :order_reference_group_images,
      :order_reference_id,
      :order_reference_group_id
  end
end
