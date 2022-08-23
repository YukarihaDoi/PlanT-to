class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.text :comment, null: false
      t.bigint :user_id, foreign_key: true
      t.bigint :post_image_id, foreign_key: true
      t.timestamps
    end
  end
end
