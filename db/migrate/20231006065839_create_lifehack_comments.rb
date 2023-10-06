class CreateLifehackComments < ActiveRecord::Migration[6.1]
  def change
    create_table :lifehack_comments do |t|
      t.integer :user_id, null: false
      t.integer :lifehack_id, null: false
      t.text :comment, null: false

      t.timestamps
    end
  end
end
