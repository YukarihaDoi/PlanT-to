class PostImage < ApplicationRecord
  # アソシエーション
  belongs_to :user
  belongs_to :post_category
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :post_image_hashtag_relations, dependent: :destroy
  has_many :hashtags, through: :post_image_hashtag_relations

  # 画像
  has_one_attached :image

  # 画像確認/サイズ
  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/Leaf.image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit: [width, height]).processed
  end

  # いいねしているユーザーがいるかどうか
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  #DBへのコミット直前に実施する
  after_create do
    post_image = PostImage.find_by(id:id)
    hashtags  = body.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
    post_image.hashtags = []
    hashtags.uniq.map do |hashtag|
      #ハッシュタグは先頭の'#'を外した上で保存
      tag = Hashtag.find_or_create_by(hashname: hashtag.downcase.delete('#'))
      post_image.hashtags << tag
    end
  end

  before_update do
    post_image = PostImage.find_by(id:id)
    post_image.hashtags.clear
    hashtags = body.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
    hashtags.uniq.map do |hashtag|
      tag = Hashtag.find_or_create_by(hashname: hashtag.downcase.delete('#'))
      post_image.hashtags << tag
    end
  end


  # バリテーション
  validates :title, presence: true
  validates :body, presence: true
  validates :image, presence: true
end