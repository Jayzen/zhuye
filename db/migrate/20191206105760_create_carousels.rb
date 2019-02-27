class CreateCarousels < ActiveRecord::Migration[5.2]
  def change
    create_table :carousels do |t|
      t.string :name
      t.string :attach
      t.datetime :weight
      t.boolean :reveal, default: false
      t.boolean :is_name, default: false
      t.boolean :is_introduction, default: false
      t.text :introduction
      t.integer :user_id

      t.timestamps
    end
    add_index :carousels, :user_id
  end
end
