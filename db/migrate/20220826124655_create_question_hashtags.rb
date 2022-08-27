class CreateQuestionHashtags < ActiveRecord::Migration[6.1]
  def change
    create_table :question_hashtags do |t|
      t.string :question_hashname
      t.timestamps
    end
    add_index :question_hashtags, :question_hashname, unique: true
  end
end
