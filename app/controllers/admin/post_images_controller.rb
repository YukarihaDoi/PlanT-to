class Admin::PostImagesController < ApplicationController
 before_action :login_check, only: [:new, :index, :show, :edit, :hashtag ]

  # 投稿一覧
  def index
    @post_images = params[:post_category].present? ? PostCategory.find(params[:post_category]).post_images: PostImage.all
    @hashtags = Hashtag.all.to_a.group_by{ |hashtag| hashtag.post_images.count}
    @post_categories = PostCategory.all
    @question_categories =QuestionCategory.all
  end

  # 投稿詳細
  def show
    @post_categories = PostCategory.all
    @question_categories =QuestionCategory.all
    @post_image = PostImage.find(params[:id])
    @user = @post_image.user
    @comment = Comment.new
  end

  # 投稿編集
  def edit
    @post_categories = PostCategory.all
    @question_categories =QuestionCategory.all
    @post_image = PostImage.find(params[:id])
    if @post_image.user == current_user
      render :edit
    else
      redirect_to post_images_path
    end
  end

  # 投稿更新
  def update
    @post_image = PostImage.find(params[:id])
    @post_image.update(post_image_params)
     redirect_to post_images_path
  end

  # 投稿削除
  def destroy
    @post_image = PostImage.find(params[:id])
    @post_image.destroy
    redirect_to post_images_path
  end

  # ハッシュ
  def hashtag
    @post_categories = PostCategory.all
    @question_categories =QuestionCategory.all
    @user = current_user
    if params[:name].nil?
      @hashtags = Hashtag.all.to_a.group_by{ |hashtag| hashtag.post_images.count}
    else
      @hashtag = Hashtag.find_by(hashname: params[:name])
      @post_image = @hashtag.post_images.reverse_order
      @hashtags = Hashtag.all.to_a.group_by{ |hashtag| hashtag.post_images.count}
      @post_images = @hashtag.post_images.all
    end
  end

  private

  def post_image_params
    params.require(:post_image).permit(:title, :image, :body, :hashbody, :user_id, :post_category_id)
  end

  def login_check
    unless signed_in?
      redirect_to root_path
    end
  end


end
