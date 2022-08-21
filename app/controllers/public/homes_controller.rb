class Public::HomesController < ApplicationController
before_action :login_check, only: [:about]

# トップ画面
  def top
  end
# アバウト画面
  def about
  end

  def login_check
    unless signed_in?
    redirect_to root_path
    end
  end

end
