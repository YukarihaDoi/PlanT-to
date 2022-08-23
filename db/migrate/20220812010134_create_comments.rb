class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.text :comment, null: false
      t.references :user, foreign_key: true, type: :integer
      t.references :post_image, foreign_key: true, type: :integer
      t.timestamps
    end
  end
end
