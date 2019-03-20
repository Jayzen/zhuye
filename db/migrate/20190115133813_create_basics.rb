class CreateBasics < ActiveRecord::Migration[5.2]
  def change
    create_table :basics do |t|
      t.string :name
      t.text :keywords
      t.string :background
      t.boolean :is_name, default: false
      t.integer :user_id

      t.timestamps
    end
    add_index :basics, :user_id
  end
end
