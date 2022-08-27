class QuestionFavorite < ApplicationRecord
  # アソシエーション
  belongs_to :user
  belongs_to :question
end
