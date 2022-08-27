class Public::QuestionsController < ApplicationController

  before_action :login_check, only: [:new, :index, :show, :edit ]
  before_action :side_view, only: [ :new, :index, :show, :edit, :hashtag]

  def new
    @question =Question.new
  end

  def create
    @question = Question.new(question_params)
    @question.user_id = current_user.id
    if @question.save
     redirect_to questions_path
    else
     @post_categories = PostCategory.all
     @question_categories =QuestionCategory.all
     @hashtags = Hashtag.all.to_a.group_by{ |hashtag| hashtag.post_images.count}
     @question =Question.new
     render :new
    end
  end

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
    if @question.user == current_user
      render :edit
    else
      redirect_to question_path(@question)
    end
  end

  def update
    @question = Question.find(params[:id])
     if @question.update(question_params)
       redirect_to question_path(@question)
     else
       @question = Question.find(params[:id])
       @post_categories = PostCategory.all
       @question_categories =QuestionCategory.all
       @hashtags = Hashtag.all.to_a.group_by{ |hashtag| hashtag.post_images.count}
       render:edit
     end
  end

  def destroy
     @question = Question.find(params[:id])
     @question.destroy
     redirect_to questions_path
  end

  # ハッシュ
  def hashtag
    @user = current_user
    if params[:name].nil?
      @question_hashtags = QuestionHashtag.all.to_a.group_by{ |question_hashtag| question_hashtag.questions.count}
    else
      @question_hashtag = QuestionHashtag.find_by(question_hashname: params[:name])
      @question = @question_hashtag.questions.reverse_order
      @question_hashtags = QuestionHashtag.all.to_a.group_by{ |question_hashtag| question_hashtag.questions.count}
      @questions = @question_hashtag.questions.all
    end

  end



  private

  # 許可
  def question_params
    params.require(:question).permit(:question_title, :question_image,:question_body ,:user_id, :question_category_id)
  end

  # ログインの確認
  def login_check
    unless signed_in?
      redirect_to root_path
    end
  end

  # サイドバー
  def side_view
    @post_categories = PostCategory.all
    @question_categories =QuestionCategory.all
    @hashtags = Hashtag.all.to_a.group_by{ |hashtag| hashtag.post_images.count}
  end

end
