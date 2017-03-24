class CreateNoteReplies < ActiveRecord::Migration[5.0]
  def change
    create_table :note_replies do |t|
      t.references :user, null: false
      t.references :note, null: false
      t.text :body, null: false
      t.timestamps
    end

    add_foreign_key :note_replies, :users, on_delete: :cascade
    add_foreign_key :note_replies, :notes, on_delete: :cascade

  end
end
