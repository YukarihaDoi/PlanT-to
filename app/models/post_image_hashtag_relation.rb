class PostImageHashtagRelation < ApplicationRecord
  belongs_to :post_image
  belongs_to :hashtag
  with_options presence: true do
   validates :post_image_id, presence: true
   validates :hashtag_id, presence: true
  end
end