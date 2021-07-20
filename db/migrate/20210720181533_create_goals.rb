class CreateGoals < ActiveRecord::Migration[5.2]
  def change
    create_table :goals do |t|
      t.string :title, null: false
      t.text :description, null: false
      t.boolean :completed, null: false, default: false
      t.boolean :private, null: false, default: false
      t.integer :creator_id, null: false, user: :references
      t.timestamps
    end
  end
end
