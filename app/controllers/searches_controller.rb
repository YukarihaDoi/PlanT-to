class SearchesController < ApplicationController
  def search
    @post_images = PostImage.where("title LIKE?", "%#{params[:word]}%")
    @post_images_all = PostImage.all
    @users = User.where("name LIKE?", "%#{params[:word]}%")
    @usars_all = User.all
    @post_categories = PostCategory.all
    @question_categories =QuestionCategory.all
  end
end