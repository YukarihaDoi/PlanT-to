class Admin::PostImagesController < ApplicationController
 before_action :authenticate_admin!, only: [:show,:new, :index, :edit, :hashtag]
 before_action :side_view, only: [:index, :show, :edit, :hashtag,:update ]

  # 投稿一覧
  def index
    @post_images = params[:post_category].present? ? PostCategory.find(params[:post_category]).post_images: PostImage.all
    @hashtags = Hashtag.all.to_a.group_by{ |hashtag| hashtag.post_images.count}
  end

  # 投稿詳細
  def show
    @post_image = PostImage.find(params[:id])
    @user = @post_image.user
    @comment = Comment.new
  end

  # 投稿編集
  def edit
    @post_image = PostImage.find(params[:id])
  end

  # 投稿更新
  def update
    @post_image = PostImage.find(params[:id])
    if @post_image.update(post_image_params)
       redirect_to admin_post_images_path
    else
      render:edit
    end
  end
  # 投稿削除
  def destroy
    @post_image = PostImage.find(params[:id])
    @post_image.destroy
    redirect_to admin_post_images_path
  end

  # ハッシュ
  def hashtag
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

  def side_view
    @post_categories = PostCategory.all
    @hashtags = Hashtag.all.to_a.group_by{ |hashtag| hashtag.post_images.count}
  end
end
