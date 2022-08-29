class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  ##画像
  has_one_attached :news_image
  # 画像確認/サイズ
  def get_news_image(width, height)
    unless news_image.attached?
      # ここの画像直す
      file_path = Rails.root.join('app/assets/images/no-post_image.jpg')
      news_image.attach(io: File.open(file_path), filename: 'no-post_image.jpg', content_type: 'image/jpeg')
    end
    news_image.variant(resize_to_limit: [width, height]).processed
  end
end