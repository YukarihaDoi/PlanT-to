class Admin::NewsImagesController < ApplicationController

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
    @news_image.update(news_image_params)
    redirect_to admin_news_images_path
  end

  private

  def news_image_params
    params.require(:news_image).permit(:news_title, :news_image, :news_body, :admin_id)
  end
end
