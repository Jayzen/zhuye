class CreateSetAdvertises < ActiveRecord::Migration[5.2]
  def change
    create_table :set_advertises do |t|
      t.string :contact
      t.integer :map_height
      t.integer :user_id

      t.timestamps
    end
    add_index :set_advertises, :user_id
  end
end
