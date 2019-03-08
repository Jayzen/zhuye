class CreateSetDimensions < ActiveRecord::Migration[5.2]
  def change
    create_table :set_dimensions do |t|
      t.string :logo
      t.integer :user_id

      t.timestamps
    end
    add_index :set_dimensions, :user_id
  end
end
