class CreateLifehacks < ActiveRecord::Migration[6.1]
  def change
    create_table :lifehacks do |t|
      t.integer :user_id, null: false
      t.string :title, null: false
      t.text :body, null: false
      t.string :star
      t.string :tag
      t.boolean :is_draft, default: false

      t.timestamps
    end
  end
end
