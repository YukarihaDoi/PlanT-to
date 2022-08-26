class QuestionCategory < ApplicationRecord
  has_many :questions, dependent: :destroy

  validates :question_category, presence: true
end
