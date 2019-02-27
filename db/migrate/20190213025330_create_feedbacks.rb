class CreateFeedbacks < ActiveRecord::Migration[5.2]
  def change
    create_table :feedbacks do |t|
      t.string :name
      t.text :content
      t.integer :user_id
      t.boolean :status, default: false

      t.timestamps
    end

    add_index :feedbacks, :user_id
  end
end
