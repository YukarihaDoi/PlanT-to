class CreatePostImages < ActiveRecord::Migration[6.1]
  def change
    create_table :post_images do |t|
      t.string :title, null: false
      t.text :body, null: false
      t.bigint :user_id, foreign_key: true
      t.bigint :post_category_id, foreign_key: true
      t.timestamps
    end
  end
end
