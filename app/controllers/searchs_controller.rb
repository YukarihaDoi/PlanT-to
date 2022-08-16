class SearchsController < ApplicationController
  def search
    @post_images = Item.where("name LIKE?", "%#{params[:word]}%")
    @post_images_all = PostImage.all
  end
end
