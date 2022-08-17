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
  # ゲストログイン
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end
  # 管理者
  namespace :admin do
    get '/' => 'homes#top'
  end
  # 検索
  get "search" => "searches#search"

  # ハッシュ
  get '/post_image/hashtag/:name' => 'post_images#hashtag'
  get '/post_image/hashtag' => 'post_images#hashtag'

  # ユーザー(ファイル構成違うため、module)
  scope module: :public do
    root to: 'homes#top'
    get '/about' => 'homes#about' , as: 'about'
    get 'relationships/followings'
    get 'relationships/followers'
    get "users/:id/following" => "users#following" ,as:"following"
    get "users/:id/follower" => "users#follower" ,as:"follower"

    resources :users, only: [:show, :index, :edit, :update] do
      post 'follow/:id' => 'relations#create', as: 'follow'
      post 'unfollow/:id' => 'relations#destroy', as: 'unfollow'
    end

    resources :post_images, only: [:new, :create, :show, :index, :edit, :update, :destroy] do
      resources :comments, only: [:create, :destroy]
      resource :favorites, only: [:create, :destroy]
    end

    resources :questions, only: [:new, :create, :show, :index, :edit, :update, :destroy] do
      resources :comments, only: [:destroy]
      post 'comments' => 'comments#answer'
      resource :favorites, only: [:create, :destroy]
    end
  end

end
