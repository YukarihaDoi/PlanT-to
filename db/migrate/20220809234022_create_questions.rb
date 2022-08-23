class CreateQuestions < ActiveRecord::Migration[6.1]
  def change
    create_table :questions do |t|
      t.string :question_title, null: false
      t.text :question_body, null: false
      t.references :user, foreign_key: true, type: :integer
      t.references :question_category, foreign_key: true, type: :integer
      t.timestamps
    end
  end
end
