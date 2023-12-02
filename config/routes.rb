Rails.application.routes.draw do
  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  # ユーザー用
  # URL /users/sign_in ...
  devise_for :users,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

    # ゲストログイン
  devise_scope :user do
    post 'users/guest_sign_in', to: 'public/sessions#guest_sign_in'
  end

  scope module: :public do
    root to: "homes#top"
    get "/about" => "homes#about", as: "about"
    resources :lifehacks, only: [:new,:index,:show,:edit,:create,:destroy,:update] do
      #下書き一覧
      collection do
        get :index_draft
      end
      #コメント機能
      resources :lifehack_comments, only: [:create, :destroy]
      #いいね機能
      resource :favorites, only: [:create, :destroy]

    end
    resources :users, only: [:show, :update, :edit, :index] do
      collection do #id が付与されない
        get 'confirm'
        patch 'withdraw'
      end
      member do
        #ユーザーごとのいいね履歴一覧
        get :favorites
        #ユーザーごとの投稿履歴一覧
        get :index_user
      end
    end
    #通知機能
    resources :notifications, only: [:index] do
      post :update_checked, on: :collection
    end
    #キーワード検索機能
    get '/search', to: 'searches#search'
    #タグ検索機能
    get 'tagsearches/search', to: 'tagsearches#search'
  end

  namespace :admin do#URLの最初に/admin/が追加されます。
    root to: "homes#top"
    resources :users, only: [:index, :show, :edit, :update] do
      member do
        #ユーザーごとのいいね履歴一覧
        get :favorites
        #ユーザーごとの投稿履歴一覧
        get :index_user
      end
    end
    resources :lifehacks, only: [:show, :destroy]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end