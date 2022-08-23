class CreateNewsImages < ActiveRecord::Migration[6.1]
  def change
    create_table :news_images do |t|
      t.string :news_title, null: false
      t.text :news_body, null: false
      t.timestamps
    end
  end
end
