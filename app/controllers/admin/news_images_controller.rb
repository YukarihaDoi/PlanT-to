class Admin::NewsImagesController < ApplicationController

  # 新規
  def new
  @news_image = NewsImage.new
  end

  # 作成
  def create
   @news_image = NewsImage.new(news_image_params)
    if @news_image.save
       redirect_to admin_news_images_path
     else
       @news_image = NewsImage.new
       render:new
     end
  end

  # 詳細
  def index
    @news_images = NewsImage.all
  end

  # 投稿編集
  def edit
    @news_image = NewsImage.find(params[:id])
  end

  # 投稿更新
  def update
    @news_image = NewsImage.find(params[:id])
     if @news_image.update(news_image_params)
       redirect_to admin_news_images_path
     else
       @news_image = NewsImage.find(params[:id])
       render:edit
     end
  end

  private

  def news_image_params
    params.require(:news_image).permit(:news_title, :news_image, :news_body, :admin_id)
  end
end
