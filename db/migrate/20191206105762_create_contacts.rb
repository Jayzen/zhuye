class CreateContacts < ActiveRecord::Migration[5.2]
  def change
    create_table :contacts do |t|
      t.string :telephone
      t.string :address
      t.string :wechat
      t.string :qq
      t.boolean :is_telephone, default: false
      t.boolean :is_address, default: false
      t.boolean :is_wechat, default: false
      t.datetime :weight
      t.boolean :reveal, default: false
      t.integer :user_id

      t.timestamps
    end
    add_index :contacts, :user_id
  end
end
