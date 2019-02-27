class CreateArticles < ActiveRecord::Migration[5.2]
  def change
    create_table :articles do |t|
      t.string :title
      t.text :content
      t.datetime :weight
      t.boolean :reveal, default: false
      t.integer :user_id

      t.timestamps
    end
    add_index :articles, :user_id
  end
end
