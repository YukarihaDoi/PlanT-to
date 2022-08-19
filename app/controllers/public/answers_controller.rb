class Public::AnswersController < ApplicationController

  def create
    @question = Question.find(params[:question_id])
    @answer.question_id = @question.id
    @answer = current_user.answers.new(answer_params)
    @answer.save
    redirect_to question_path(@question)
  end

  def destroy
    Answer.find(params[:id]).destroy
    redirect_to post_image_path(params[:post_image_id])
  end

  private

  def answer_params
    params.require(:answer).permit(:answer,:question_id)
  end
end