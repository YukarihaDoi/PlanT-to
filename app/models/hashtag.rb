class Hashtag < ApplicationRecord
  validates :hashname, presence: true, length: {maximum:50}
  has_many :post_image_hashtag_relations, dependent: :destroy
  has_many :post_images, through: :post_image_hashtag_relations
end
