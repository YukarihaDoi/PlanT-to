class Question < ApplicationRecord
  # アソシエーション
  belongs_to :user
  belongs_to :question_category
  has_many :answers, dependent: :destroy
  has_many :question_favorites, dependent: :destroy
  has_many :question_hashtag_relations, dependent: :destroy
  has_many :question_hashtags, through: :question_hashtag_relations

  # 画像
  has_one_attached :question_image

  # 画像確認/サイズ
  def get_question_image(width, height)
    unless question_image.attached?
      file_path = Rails.root.join('app/assets/images/Leaf-image.jpg')
      question_image.attach(io: File.open(file_path), filename: 'Leaf-image.jpg', content_type: 'image/jpeg')
    end
    question_image.variant(resize_to_limit: [width, height]).processed
  end

  # いいねしているユーザーがいるかどうか
  def question_favorited_by?(user)
    question_favorites.exists?(user_id: user.id)
  end

  #DBへのコミット直前に実施する
  after_create do
    question = Question.find_by(id:id)
    question_hashtags  = question_body.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
    question.question_hashtags = []
    question_hashtags.uniq.map do |hashtag|
      #ハッシュタグは先頭の'#'を外した上で保存
      tag = QuestionHashtag.find_or_create_by(question_hashname: hashtag.downcase.delete('#'))
      question.question_hashtags << tag
    end
  end

  before_update do
    question = Question.find_by(id:id)
    question.question_hashtags.clear
    question_hashtags = question_body.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
    question_hashtags.uniq.map do |hashtag|
      tag = QuestionHashtag.find_or_create_by(question_hashname: hashtag.downcase.delete('#'))
      question.question_hashtags << tag
    end
  end

  # 検索
  def self.search_for(word, search)
    if search == "perfect_match"
      Question.where(question_title:word)
    elsif search == "forward_match"
      Question.where('question_title LIKE?',word+'%')
    elsif search == "backward_match"
      Question.where('question_title LIKE?','%'+word)
    elsif search == "partial_match"
      Question.where('question_title LIKE?','%'+word+'%')
    else
     Question.all
    end
  end

  validates :question_title, presence: true
  validates :question_body, presence: true
  validates :question_category, presence: true

end