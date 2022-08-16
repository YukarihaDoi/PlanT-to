class SearchesController < ApplicationController
  def search
    @post_images = PostImage.where("title LIKE?", "%#{params[:word]}%")
    @post_images_all = PostImage.all
  end
end