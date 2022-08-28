class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # 会員名
  validates :name, presence: true, length: { minimum: 2, maximum: 20 }, uniqueness: true

  ##アソシエーション
  has_many :post_images, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_post_images, through: :favorites, source: :post_image

  has_many :follower, class_name: "Relation", foreign_key: "follower_id", dependent: :destroy
  has_many :following_user, through: :follower, source: :followed
  has_many :followed, class_name: "Relation", foreign_key: "followed_id", dependent: :destroy
  has_many :followed_user, through: :followed, source: :follower


  ##画像
  has_one_attached :profile_image

  # 画像確認/サイズ
  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_user.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'no_user.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end

  ##フォロー/フォロワー
  # フォローする
  def follow(user_id)
  follower.create(followed_id: user_id)
  end
  # フォロー外す
  def unfollow(user_id)
  follower.find_by(followed_id: user_id).destroy
  end
  # フォロー確認
  def following?(user)
  following_user.include?(user)
  end

  # ゲスト
  def self.guest
    find_or_create_by!(name: 'guestuser' ,email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "guestuser"
    end
  end

  # 検索
  def self.search_for(word, search)
      if search == "perfect_match"
        User.where(name:word)
      elsif search == "forward_match"
        User.where('name LIKE ?', word+'%')
      elsif search == "backward_match"
        User.where('name LIKE ?', '%'+word)
      elsif search == "partial_match"
        User.where('name LIKE ?', '%'+word+'%')
      else
      
      end
  end
  #バリテーション
    validates :name, presence: true
end
