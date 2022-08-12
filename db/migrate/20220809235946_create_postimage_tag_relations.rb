class CreatePostimageTagRelations < ActiveRecord::Migration[6.1]
  def change
    create_table :postimage_tag_relations do |t|
      t.references :Postimage, null: false, foreign_key: true
      t.references :tag, null: false, foreign_key: true
      t.timestamps
    end
  end
end
