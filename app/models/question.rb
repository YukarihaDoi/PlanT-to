class Question < ApplicationRecord
  # アソシエーション
  belongs_to :user
  belongs_to :question_category
  has_many :answers, dependent: :destroy
  # 画像
  has_one_attached :question_image

  # 画像確認/サイズ
  def get_question_image(width, height)
    unless question_image.attached?
      file_path = Rails.root.join('app/assets/images/sample-author1.jpg')
      question_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    question_image.variant(resize_to_limit: [width, height]).processed
  end

end