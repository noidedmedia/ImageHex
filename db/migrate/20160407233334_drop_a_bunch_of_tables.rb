class DropABunchOfTables < ActiveRecord::Migration
  def change
    drop_table :commission_offers, force: :cascade
    drop_table :commission_images, force: :cascade
    drop_table :commission_subjects, force: :cascade
    drop_table :commission_subject_tags, force: :cascade
    drop_table :commission_backgrounds, force: :cascade
    drop_table :listings, force: :cascade
    drop_table :listing_example_images, force: :cascade
  end
end
