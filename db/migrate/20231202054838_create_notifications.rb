class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|
      t.integer :visitor_id, null: false
      t.integer :visited_id, null: false
      t.integer :lifehack_id
      t.integer :lifehack_comment_id
      t.integer :favorite_id
      t.string :action, null: false, default: ''
      t.boolean :is_checked, null: false, default: false

      t.timestamps
    end
  end
end
