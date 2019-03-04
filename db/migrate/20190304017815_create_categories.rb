class CreateCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :categories do |t|
      t.string :name
      t.datetime :weight
      t.boolean :reveal, default: false
      t.integer :user_id

      t.timestamps
    end
    add_index :categories, :user_id
  end
end
