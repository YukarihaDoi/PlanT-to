Rails.application.routes.draw do

  namespace :public do
    get 'question_post_images/show'
    get 'question_post_images/index'
    get 'question_post_images/create'
    get 'question_post_images/destroy'
  end
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
    root to: 'post_images#index'
    get '/about' => 'homes#about' , as: 'about'
    resources :users, only: [:show, :index, :edit, :update]
    resources :post_images, only: [:show, :index, :edit, :update]
  end

end
