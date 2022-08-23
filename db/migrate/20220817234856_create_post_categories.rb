class CreatePostCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :post_categories do |t|
      t.string :post_category, null: false
      t.timestamps
    end
  end
end
