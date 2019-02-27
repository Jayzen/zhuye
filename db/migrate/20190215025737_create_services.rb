class CreateServices < ActiveRecord::Migration[5.2]
  def change
    create_table :services do |t|
      t.string :name
      t.text :description
      t.integer :user_id
      t.datetime :weight
      t.boolean :reveal, default: false

      t.timestamps
    end
    add_index :services, :user_id
  end
end
