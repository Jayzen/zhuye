class CreateLogos < ActiveRecord::Migration[5.2]
  def change
    create_table :logos do |t|
      t.string :name
      t.integer :user_id

      t.timestamps
    end
    add_index :logos, :user_id
  end
end
