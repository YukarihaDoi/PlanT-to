class Public::UsersController < ApplicationController
before_action :ensure_currect_user, only: [:edit,:update]
before_action :authenticate_user!, only: [:show]
before_action :ensure_guest_user, only: [:edit]
before_action :login_check, only: [ :index, :show, :edit, :follower, :following ]

  def show
    @user = User.find(params[:id])
    @post_images = @user.post_images
    @post_categories = PostCategory.all
    @questions = @user.questions
    @question_categories =QuestionCategory.all
  end

  def index
    # ゲストユーザー以外のデータを取得
    @users = User.where.not(name: 'guestuser')
  end

  def edit
    @user = User.find(params[:id])
    @post_categories = PostCategory.all
    @question_categories =QuestionCategory.all
  end

  def update
    @user = User.find(params[:id])
    @post_categories = PostCategory.all
    @question_categories =QuestionCategory.all
    if @user.update(user_params)
      redirect_to user_path(current_user.id), notice: "You have updated user successfully."
    else
      render :edit
    end
  end

  # フォロワー 一覧画面
  def follower
   @user = User.find(params[:id])
   @post_categories = PostCategory.all
   @question_categories =QuestionCategory.all

  end
  # フォロー 一覧画面
  def following
   @user = User.find(params[:id])
   @post_categories = PostCategory.all
   @question_categories =QuestionCategory.all
  end

   #いいね一覧
   def favorites
    @user = User.find(params[:id])
    favorites= Favorite.where(user_id: @user.id).pluck(:post_image_id)
    @favorite_posts = PostImage.find(favorites)
    @post_categories = PostCategory.all
   @question_categories =QuestionCategory.all
   end

   #質問一覧
   def questions
    @user = User.find(params[:id])
    @questions = @user.questions
    @question_categories =QuestionCategory.all
    @post_categories = PostCategory.all
   end


private
   def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
   end

    def ensure_currect_user
     @user = User.find(params[:id])
      unless @user == current_user
       redirect_to user_path(current_user.id)
      end
    end

    def ensure_guest_user
      @user = User.find(params[:id])
      if @user.name == "guestuser"
        redirect_to user_path(current_user) , notice: 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
      end
    end

    def login_check
      unless signed_in?
      redirect_to root_path
      end
    end
end
