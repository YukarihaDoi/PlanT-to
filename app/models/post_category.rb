class PostCategory < ApplicationRecord
  has_many :post_images, dependent: :destroy
end
