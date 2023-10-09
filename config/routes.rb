Rails.application.routes.draw do
  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  scope module: :public do
    root to: "homes#top"
    get "/about" => "homes#about", as: "about"
    resources :lifehacks, only: [:new,:index,:show,:edit,:create,:destroy,:update] do
      #コメント機能
      resources :lifehack_comments, only: [:create, :destroy]
      #いいね機能
      resource :favorites, only: [:create, :destroy]
    end

    resource :users, only: [:show, :update] #:idを持たせないためresouce
    get "/users/information/edit" => "users#edit"
    get "/users/confirm" => "users#confirm"
    patch "/users/withdraw" => "users#withdraw"
    #キーワード検索機能
    get '/search', to: 'searches#search'

  end

  namespace :admin do#URLの最初に/admin/が追加されます。
    root to: "homes#top"
    resources :users, only: [:index, :show, :edit, :update]
  end

  # ユーザー用
  # URL /users/sign_in ...
  devise_for :users,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
