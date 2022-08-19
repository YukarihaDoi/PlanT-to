class Public::QuestionsController < ApplicationController
  def new
    @question =Question.new
  end

  def create
    @question = Question.new(question_params)
    @question.user_id = current_user.id
    if @question.save
     redirect_to questions_path
    else
     render :new
    end
  end

  def index
     @questions =Question.all
     @question_categories =QuestionCategory.all
  end

  def show
    @question = Question.find(params[:id])
    @user = @question.user
    @answer = Answer.new
  end

  def edit
    @question = Question.find(params[:id])
    if @question.user == current_user
      render :edit
    else
      redirect_to questions_path
    end
  end

  def update
    @question = Question.find(params[:id])
    @question.update(question_params)
    redirect_to questions_path
  end

  def destroy
     @question = Question.find(params[:id])
     @question.destroy
     redirect_to questions_path
  end

  private

  def question_params
    params.require(:question).permit(:question_title, :question_image, :question_body)
  end
end
