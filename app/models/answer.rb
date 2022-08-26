class Answer < ApplicationRecord
  # アソシエーション
  belongs_to :user
  belongs_to :question

validates :answer, presence: true

end