class CreatePhotographs < ActiveRecord::Migration[5.2]
  def change
    create_table :photographs do |t|
      t.string :name
      t.string :image
      t.integer :user_id
      t.datetime :weight
      t.boolean :reveal, default: false
      t.timestamps
    end

    add_index :photographs, :user_id
  end
end
