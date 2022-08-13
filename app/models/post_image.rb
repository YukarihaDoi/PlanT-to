class PostImage < ApplicationRecord
  # アソシエーション
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  # 画像
  has_one_attached :image

  # 画像確認/サイズ
  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/sample-author1.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit: [100, 100]).processed
  end
  
  # いいねしているユーザーがいるかどうか
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
  
  # バリテーション 
  validates :title, presence: true
  validates :body, presence: true
  validates :image, presence: true

end