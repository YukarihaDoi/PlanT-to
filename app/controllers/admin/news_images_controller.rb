class Admin::NewsImagesController < ApplicationController
  
  before_action :login_check, only: [:index, :show, :edit, :new]

  # 新規
  def new
  @news_image = NewsImage.new
  end

  # 作成
  def create
   @news_image = NewsImage.new(news_image_params)
    if @news_image.save
       redirect_to admin_news_images_path, notice: '投稿に成功しました'
    else
       render:new
    end
  end

  # 詳細
  def index
    @news_images = NewsImage.all.order(created_at: :desc)
  end

  # 投稿編集
  def edit
    @news_image = NewsImage.find(params[:id])
  end

  # 投稿更新
  def update
    @news_image = NewsImage.find(params[:id])
     if @news_image.update(news_image_params)
       redirect_to admin_news_images_path, notice: '更新に成功しました'
     else
       render:edit
     end
  end

  private

  # 許可
  def news_image_params
    params.require(:news_image).permit(:news_title, :news_image, :news_body, :admin_id)
  end

  # ログインしているかどうか
  def login_check
    unless signed_in?
    redirect_to root_path
    end
  end

end
