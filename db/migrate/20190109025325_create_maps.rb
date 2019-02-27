class CreateMaps < ActiveRecord::Migration[5.2]
  def change
    create_table :maps do |t|
      t.string :name
      t.integer :level
      t.string :longitude
      t.string :latitude
      t.integer :user_id
      t.datetime :weight

      t.timestamps
    end
    add_index :maps, :user_id
  end
end
