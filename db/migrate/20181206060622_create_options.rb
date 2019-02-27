class CreateOptions < ActiveRecord::Migration[5.2]
  def change
    create_table :options do |t|
      t.string :name
      t.string :show
      t.integer :position
      t.boolean :reveal, default: false

      t.integer :user_id
      t.timestamps
    end
    add_index :options, :user_id
  end
end
