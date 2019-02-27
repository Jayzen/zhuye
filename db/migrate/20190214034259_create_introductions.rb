class CreateIntroductions < ActiveRecord::Migration[5.2]
  def change
    create_table :introductions do |t|
      t.string :title
      t.text :content
      t.integer :user_id
      t.datetime :weight
      t.boolean :reveal, default: false

      t.timestamps
    end
    add_index :introductions, :user_id
  end
end
