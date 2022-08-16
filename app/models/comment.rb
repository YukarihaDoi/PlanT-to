class Comment < ApplicationRecord
  # アソシエーション
  belongs_to :user
  belongs_to :post_image
  belongs_to :question
end