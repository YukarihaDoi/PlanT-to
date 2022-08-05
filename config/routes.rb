Rails.application.routes.draw do

  # 管理者用devise
  devise_for :admin,skip: [:passwords], controllers: {
  registrations: "admin/registrations",
  sessions: "admin/sessions"
  }

  # ユーザー用devise
  devise_for :users,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
  }

  # 管理者
  namespace :admin do
    get '/' => 'homes#top'
  end

  # ユーザー(ファイル構成違うため、module)
  scope module: :public do
    root to: 'homes#top'
    get '/about' => 'homes#about' , as: 'about'
    resources :users, only: [:show, :index, :edit, :update]
  end

end
