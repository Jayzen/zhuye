class CreateNavbars < ActiveRecord::Migration[5.2]
  def change
    create_table :navbars do |t|
      t.string :position
      t.string :color
      t.string :background
      t.integer :user_id

      t.timestamps
    end
    add_index :navbars, :user_id
  end
end
