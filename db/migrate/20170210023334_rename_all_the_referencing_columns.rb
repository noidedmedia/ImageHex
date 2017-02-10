class RenameAllTheReferencingColumns < ActiveRecord::Migration[5.0]
  def change
    rename_column :order_group_images,
      :order_reference_group_id,
      :order_group_id

    rename_column :order_group_tags,
      :order_reference_group_id,
      :order_group_id

  end
end
