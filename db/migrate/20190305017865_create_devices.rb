class CreateDevices < ActiveRecord::Migration[5.2]
  def change
    create_table :devices do |t|
      t.string :name
      t.text :details
      t.string :location
      t.boolean :status
      t.datetime :weight
      t.boolean :reveal, default: false
      t.integer :user_id
      t.integer :category_id
      t.string :qr_code_uid
      t.string :qr_code_name

      t.timestamps
    end
    add_index :devices, :user_id
    add_index :devices, :category_id
  end
end
