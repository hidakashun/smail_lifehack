class AddScoreToLifehacks < ActiveRecord::Migration[6.1]
  def change
    add_column :lifehacks, :score, :decimal, precision: 5, scale: 3
  end
end
