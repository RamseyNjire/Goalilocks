class CreateGoals < ActiveRecord::Migration[5.2]
  def change
    create_table :goals do |t|
      t.string :title, null: false
      t.text :description
      t.boolean :is_complete, null: false, default: false
      t.boolean :is_private, null: false, default: false
      t.references :creator, user: :references, index: true
      t.timestamps
    end
  end
end
