class Public::QuestionsController < ApplicationController
before_action :login_check, only: [:new, :index, :show, :edit ]
  def new
    @question =Question.new
    @post_categories = PostCategory.all
    @question_categories =QuestionCategory.all
  end

  def create
    p "question action"
    @question = Question.new(question_params)
    @question.user_id = current_user.id
    if @question.save
     redirect_to questions_path
    else
     render :new
    end
  end

  def index
    @questions =params[:question_category].present? ? QuestionCategory.find(params[:question_category]).questions: Question.all
    @post_categories = PostCategory.all
    @question_categories =QuestionCategory.all
  end

  def show
    @question = Question.find(params[:id])
    @user = @question.user
    @answer = Answer.new
    @questions =params[:question_category].present? ? QuestionCategory.find(params[:question_category]).questions: Question.all
    @post_categories = PostCategory.all
    @question_categories =QuestionCategory.all
  end

  def edit
    @post_categories = PostCategory.all
    @question_categories =QuestionCategory.all
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
    params.require(:question).permit(:question_title, :question_image, :question_body ,:user_id, :question_category_id)
  end

  def login_check
    unless signed_in?
      redirect_to root_path
    end
  end

end
