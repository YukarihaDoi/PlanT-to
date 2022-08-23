class CreateAnswers < ActiveRecord::Migration[6.1]
  def change
    create_table :answers do |t|
      t.text :answer, null: false
      t.bigint :user_id, foreign_key: true
      t.bigint :question_id, foreign_key: true
      t.timestamps
    end
  end
end
