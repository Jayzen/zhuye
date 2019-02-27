class CreateEmployees < ActiveRecord::Migration[5.2]
  def change
    create_table :employees do |t|
      t.string :name
      t.string :avatar
      t.string :deputy
      t.text :introduction
      t.datetime :weight
      t.boolean :reveal, default: false
      t.integer :user_id

      t.timestamps
    end
    add_index :employees, :user_id
  end
end
