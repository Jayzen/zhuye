class CreateDeviceAttaches < ActiveRecord::Migration[5.2]
  def change
    create_table :device_attaches do |t|
      t.string :name
      t.integer :device_id

      t.timestamps
    end
    add_index :device_attaches, :device_id
  end
end
