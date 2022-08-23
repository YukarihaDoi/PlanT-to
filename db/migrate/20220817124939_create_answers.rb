class CreateAnswers < ActiveRecord::Migration[6.1]
  def change
    create_table :answers do |t|
      t.text :answer, null: false
      t.references :user, foreign_key: true, type: :integer
      t.references :question, foreign_key: true, type: :integer
      t.timestamps
    end
  end
end
