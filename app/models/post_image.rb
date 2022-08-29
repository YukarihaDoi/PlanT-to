class PostImage < ApplicationRecord
  # アソシエーション
  belongs_to :user
  belongs_to :post_category
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :post_image_hashtag_relations, dependent: :destroy
  has_many :hashtags, through: :post_image_hashtag_relations
  has_many :favorite_users, through: :favorites, source: :user

  # 画像
  has_one_attached :image

  # 画像確認/サイズ
  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no-post_image.jpg')
      image.attach(io: File.open(file_path), filename: 'no-post_image.jpg', content_type: 'image/jpeg')
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

  # 検索
  def self.search_for(word, search)
    if search == "perfect_match"
      PostImage.where(title:word)
    elsif search == "forward_match"
      PostImage.where('title LIKE?',word+'%')
    elsif search == "backward_match"
      PostImage.where('title LIKE?','%'+word)
    elsif search == "partial_match"
      PostImage.where('title LIKE?','%'+word+'%')
    else

    end
  end

  validates :title, presence: true
  validates :body, presence: true
  validates :post_category, presence: true
end