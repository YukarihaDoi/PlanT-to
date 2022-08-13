class CreatePostImages < ActiveRecord::Migration[6.1]
  def change
    create_table :post_images do |t|
      t.string :title, null: false
      t.text :body, null: false
      t.integer :user_id
      t.timestamps
    end
  end
end
