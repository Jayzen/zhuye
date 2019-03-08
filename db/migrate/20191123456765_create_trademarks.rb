class CreateTrademarks < ActiveRecord::Migration[5.2]
  def change
    create_table :trademarks do |t|
      t.string :name
      t.integer :user_id
      t.boolean :reveal, default: false

      t.timestamps
    end
    add_index :trademarks, :user_id
  end
end
