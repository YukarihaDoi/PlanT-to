class SearchesController < ApplicationController
  def search
    @post_categories = PostCategory.all
    @question_categories =QuestionCategory.all
    @method = params[:method]
    @word = params[:word]
    @search = params[:search]

    if @method == "PostImage"
       @post_images = PostImage.search_for(@word,@search)

    elsif @method == "User"
       @users = User.search_for(@word,@search)

    else
      @questions = Question.search_for(@word,@search)
    end
  end
end