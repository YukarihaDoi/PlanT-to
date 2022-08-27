Rails.application.routes.draw do

  # 管理者用devise
  devise_for :admin,skip: [:registrations,:passwords], controllers: {
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
    resources :post_categories, only: [:index, :create, :edit, :update]
    resources :question_categories, only: [:index, :create, :edit, :update]
    resources :post_images, only: [:show, :index, :edit, :update, :destroy]
    resources :users, only: [:show, :index,:edit,:update]
    resources :questions, only: [:show, :index, :edit, :update, :destroy]
    resources :news_images, only: [:new,:create, :index, :edit, :update ]
  end
  # 検索
  get "search" => "searches#search"
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
      # users/:id/favorites というルーティング
      member do
        get :favorites
        get :questions
        get :post_images
      end
    end
    # ハッシュ
    get '/post_images/hashtag/:name' => 'post_images#hashtag'
    get '/post_images/hashtag' => 'post_images#hashtag'
    get '/questions/hashtag/:name' => 'questions#hashtag'
    get '/questions/hashtag' => 'questions#hashtag'

    resources :post_images, only: [:new, :create, :show, :index, :edit, :update, :destroy] do
      resources :comments, only: [:create, :destroy]
      resource :favorites, only: [:create, :destroy]
    end

    resources :questions, only: [:new, :create, :show, :index, :edit, :update, :destroy] do
       resources :answers, only: [:create, :destroy]
       resource :question_favorites, only: [:create, :destroy]
    end
  end

end
