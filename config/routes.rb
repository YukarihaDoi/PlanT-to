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
    get 'relationships/followings'
    get 'relationships/followers'
    get "users/:id/following" => "users#following" ,as:"following"
    get "users/:id/follower" => "users#follower" ,as:"follower"

    resources :users, only: [:show, :index, :edit, :update] do
      post 'follow/:id' => 'relation#create', as: 'follow'
      post 'unfollow/:id' => 'relation#destroy', as: 'unfollow'
    end

    resources :post_images, only: [:new, :create, :show, :index, :edit, :update] do
      resources :comments, only: [:create,:destroy]
      resource :favorites, only: [:create, :destroy]
    end

    resources :questions, only: [:show, :index, :edit, :update] do
      resources :comments, only: [:create,:destroy]
      resource :favorites, only: [:create, :destroy]
    end
  end

end
