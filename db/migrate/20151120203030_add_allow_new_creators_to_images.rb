class AddAllowNewCreatorsToImages < ActiveRecord::Migration
  def change
    add_column :images, :allow_new_creators,
               :boolean,
               null: false,
               default: false
  end
end
