class QuestionHashtag < ApplicationRecord
  validates :question_hashname, presence: true, length: {maximum:50}
  has_many :question_hashtag_relations, dependent: :destroy
  has_many :questions, through: :question_hashtag_relations
end
