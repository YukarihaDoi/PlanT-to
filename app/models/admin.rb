class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # ##画像
  # has_one_attached :admin_profile_image

  # # 画像確認/サイズ
  # def admin_profile_image(width, height)
  #   unless admin_profile_image.attached?
  #     # ここの画像直す
  #     file_path = Rails.root.join('app/assets/images/no-image_user.jpg')
  #     admin_profile_image.attach(io: File.open(file_path), filename: 'no-image_user.jpg', content_type: 'image/jpeg')
  #   end
  #   admin_profile_image.variant(resize_to_limit: [width, height]).processed
  # end
end