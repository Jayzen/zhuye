class CreatePictures < ActiveRecord::Migration[5.2]
  def change
    create_table :pictures do |t|
      t.integer :user_id
      t.string :attach

      t.timestamps
    end
    add_index :pictures, :user_id
  end
end
