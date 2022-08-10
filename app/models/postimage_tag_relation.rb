class PostimageTagRelation < ApplicationRecord
  belongs_to :Postimage
  belongs_to :tag
end
