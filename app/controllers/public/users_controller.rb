class Public::UsersController < ApplicationController

  before_action :ensure_currect_user, only: [:edit,:update]
  before_action :authenticate_user!, only: [:show]
  before_action :ensure_guest_user, only: [:edit]
  before_action :login_check, only: [ :index, :show, :edit, :follower, :following ]
  before_action :side_view, only: [ :index, :show, :edit, :follower, :following, :favorites, :questions ]

  # すべて表示（混ぜる）
  def show
    @user = User.find(params[:id])
    @post_images = @user.post_images
    @questions = @user.questions
    @mixed = (@post_images + @questions).sort_by {|record| record.created_at}.reverse
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
      redirect_to user_path(current_user.id), notice: "You have updated user successfully."
    else
      render :edit
    end
  end

  # フォロワー 一覧画面
  def follower
   @user = User.find(params[:id])

  end
  # フォロー 一覧画面
  def following
   @user = User.find(params[:id])
  end

   #いいね一覧(混ぜる！)
   def favorites
    @user = User.find(params[:id])
    favorites= Favorite.where(user_id: @user.id).pluck(:post_image_id)
    @favorite_posts = PostImage.find(favorites)
   end

   #質問一覧
   def questions
    @user = User.find(params[:id])
    @questions = @user.questions
   end

   #投稿一覧
   def post_images
   @user = User.find(params[:id])
    @post_images = @user.post_images
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

    def side_view
      @post_categories = PostCategory.all
      @question_categories =QuestionCategory.all
      @hashtags = Hashtag.all.to_a.group_by{ |hashtag| hashtag.post_images.count}
    end

end
