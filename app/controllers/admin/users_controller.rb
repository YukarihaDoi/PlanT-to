class Admin::UsersController < ApplicationController

   before_action :authenticate_admin!, only: [:show]
   before_action :login_check, only: [ :index, :show, :edit]
   before_action :side_view, only: [:index, :show, :edit]

  def show
    @user = User.find(params[:id])
    @post_images = @user.post_images
    @questions = @user.questions
  end

  def index
    # ゲストユーザー以外のデータを取得
    @users = User.where.not(name: 'guestuser')
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_user_path(@user)
    else
      @user = User.find(params[:id])
      @post_categories = PostCategory.all
      @question_categories =QuestionCategory.all
      @hashtags = Hashtag.all.to_a.group_by{ |hashtag| hashtag.post_images.count}
      render :edit
    end
  end

  private

  def user_params
   params.require(:user).permit(:name, :introduction, :email, :profile_image, :is_deleted)
  end
    def ensure_currect_user
     @user = User.find(params[:id])
      unless @user == current_user
       redirect_to user_path(current_user.id)
      end
    end

    def login_check
      unless signed_in?
      redirect_to root_path
      end
    end

    def side_view
      @post_categories = PostCategory.all
      @question_categories =QuestionCategory.all
      @hashtags = Hashtag.all.to_a.group_by{ |hashtag| hashtag.post_images.count}
    end

end
