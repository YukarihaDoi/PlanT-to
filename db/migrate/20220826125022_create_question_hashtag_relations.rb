class CreateQuestionHashtagRelations < ActiveRecord::Migration[6.1]
  def change
    create_table :question_hashtag_relations do |t|
      t.bigint :question_id, foreign_key: true
      t.bigint :question_hashtag_id, foreign_key: true
      t.timestamps
    end
  end
end
