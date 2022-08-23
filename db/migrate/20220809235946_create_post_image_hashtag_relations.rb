class CreatePostImageHashtagRelations < ActiveRecord::Migration[6.1]
  def change
    create_table :post_image_hashtag_relations do |t|
      t.bigint :post_image_id, foreign_key: true
      t.bigint :hashtag_id, foreign_key: true
      t.timestamps
    end
  end
end
