class NewsImage < ApplicationRecord
 # 画像
  has_one_attached :news_image

  # 画像確認/サイズ
  def news_get_image(width, height)
    unless news_image.attached?
      file_path = Rails.root.join('app/assets/images/exsample.jpg')
      news_image.attach(io: File.open(file_path), filename: 'exsample.jpg', content_type: 'image/jpeg')
    end
    news_image.variant(resize_to_limit: [width, height]).processed
  end
end
