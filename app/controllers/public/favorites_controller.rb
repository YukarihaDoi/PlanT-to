class Public::FavoritesController < ApplicationController

# いいね
  def create
    @post_image = PostImage.find(params[:post_image_id])
    favorite = current_user.favorites.new(post_image_id: @post_image.id)
    favorite.save
    redirect_back(fallback_location: root_path)
  end

# いいねを外す
  def destroy
    @post_image = PostImage.find(params[:post_image_id])
    favorite = current_user.favorites.find_by(post_image_id: @post_image.id)
    favorite.destroy
    redirect_back(fallback_location: root_path)
  end
end
