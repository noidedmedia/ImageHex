class RenameOrderReferenceGroupsToOrderGroups < ActiveRecord::Migration[5.0]
  def change
    rename_table :order_reference_groups, :order_groups
    rename_table :order_reference_group_images, :order_group_images
  end
end
