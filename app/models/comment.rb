class Comment < ApplicationRecord
  # アソシエーション
  belongs_to :user
  belongs_to :post_image

validates :comment, presence: true

end