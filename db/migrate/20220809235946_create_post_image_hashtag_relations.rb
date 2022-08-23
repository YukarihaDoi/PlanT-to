class CreatePostImageHashtagRelations < ActiveRecord::Migration[6.1]
  def change
    create_table :post_image_hashtag_relations do |t|
      t.references :post_image, foreign_key: true, type: :integer
      t.references :hashtag, foreign_key: true, type: :integer
      t.timestamps
    end
  end
end
