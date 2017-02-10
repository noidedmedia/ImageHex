class RenameOrderReferenceGroupTagsToOrderGroupTags < ActiveRecord::Migration[5.0]
  def change
    rename_table :order_reference_group_tags, :order_group_tags
  end
end
