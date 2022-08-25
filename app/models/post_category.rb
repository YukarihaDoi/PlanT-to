class PostCategory < ApplicationRecord
  has_many :post_images, dependent: :destroy

validates :post_category, presence: true
end
