class CreateQuestions < ActiveRecord::Migration[6.1]
  def change
    create_table :questions do |t|
      t.string :question_title, null: false
      t.text :question_body, null: false
      t.bigint :user_id, foreign_key: true
      t.bigint :question_category_id, foreign_key: true
      t.timestamps
    end
  end
end
