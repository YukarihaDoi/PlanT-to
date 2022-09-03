class Admin::UsersController < ApplicationController

  before_action :authenticate_admin!, only: [:show]
  before_action :login_check, only: [ :index, :show, :edit]

  # 詳細
  def show
    @user = User.find(params[:id])
    @post_images = @user.post_images
  end

  # 一覧
  def index
    # ゲストユーザー以外のデータを取得
    @users = User.where.not(name: 'guestuser')
  end

  # 編集
  def edit
    @user = User.find(params[:id])
  end

  # 更新
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_users_path
    else
      @user = User.find(params[:id])
      @post_categories = PostCategory.all
      @hashtags = Hashtag.all.to_a.group_by{ |hashtag| hashtag.post_images.count}
      render :edit
    end
  end

  private

  # 許可
  def user_params
   params.require(:user).permit(:name, :introduction, :email, :profile_image, :is_deleted)
  end

  # ログインしているかどうか
  def login_check
    unless signed_in?
     redirect_to root_path
    end
  end
end
