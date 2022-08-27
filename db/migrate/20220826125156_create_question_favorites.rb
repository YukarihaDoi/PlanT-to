class CreateQuestionFavorites < ActiveRecord::Migration[6.1]
  def change
    create_table :question_favorites do |t|
      t.bigint :user_id
      t.bigint :question_id
      t.timestamps
    end
  end
end
