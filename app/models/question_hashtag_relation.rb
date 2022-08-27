class QuestionHashtagRelation < ApplicationRecord
  belongs_to :question
  belongs_to :question_hashtag
  with_options presence: true do
   validates :question_id, presence: true
   validates :question_hashtag_id, presence: true
  end
end
