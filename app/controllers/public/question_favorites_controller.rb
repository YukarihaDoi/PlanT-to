class Public::QuestionFavoritesController < ApplicationController
  # いいね
  def create
    @question = Question.find(params[:question_id])
    favorite = current_user.question_favorites.new(question_id: @question.id)
    favorite.save
    # redirect_back(fallback_location: root_path)
  end

# いいねを外す
  def destroy
    @question = Question.find(params[:question_id])
    favorite = current_user.question_favorites.find_by(question_id: @question.id)
    favorite.destroy
    # redirect_back(fallback_location: root_path)
  end
end
