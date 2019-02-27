class CreateBasics < ActiveRecord::Migration[5.2]
  def change
    create_table :basics do |t|
      t.string :name
      t.string :logo
      t.text :keywords
      t.boolean :is_name, default: false
      t.boolean :is_logo, default: false
      t.integer :user_id

      t.timestamps
    end
    add_index :basics, :user_id
  end
end
