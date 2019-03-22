class CreateBasics < ActiveRecord::Migration[5.2]
  def change
    create_table :basics do |t|
      t.string :name
      t.text :keywords
      t.text :description
      t.string :background
      t.string :contact
      t.string :map_position
      t.integer :map_height, default: 500 
      t.boolean :small_map, default: false
      t.boolean :is_name, default: false
      t.integer :user_id

      t.timestamps
    end
    add_index :basics, :user_id
  end
end
