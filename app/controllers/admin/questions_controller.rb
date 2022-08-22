class Admin::QuestionsController < ApplicationController

before_action :login_check, only: [:index, :show, :edit ]
before_action :side_view, only: [:index, :show, :edit ]

  def index
    @questions =params[:question_category].present? ? QuestionCategory.find(params[:question_category]).questions: Question.all
  end

  def show
    @question = Question.find(params[:id])
    @user = @question.user
    @answer = Answer.new
    @questions =params[:question_category].present? ? QuestionCategory.find(params[:question_category]).questions: Question.all
  end

  def edit
    @question = Question.find(params[:id])
  end

  def update
    @question = Question.find(params[:id])
    @question.update(question_params)
    redirect_to admin_questions_path
  end

  def destroy
     @question = Question.find(params[:id])
     @question.destroy
     redirect_to admin_questions_path
  end

  private

  def question_params
    params.require(:question).permit(:question_title, :question_image, :question_body ,:user_id, :question_category_id)
  end

  def login_check
    unless signed_in?
      redirect_to root_path
    end
  end

  def side_view
    @post_categories = PostCategory.all
    @question_categories =QuestionCategory.all
  end
end
