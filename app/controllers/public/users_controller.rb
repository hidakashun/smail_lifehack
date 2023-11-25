class Public::UsersController < ApplicationController
  before_action :authenticate_user!, only: [:favorites, :index_user]
  before_action :is_matching_login_user, only: [:edit, :update, :destroy]

  def index
    @users = User.page(params[:page]).per(10)
                 .order(created_at: :desc)
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    if current_user.email == 'guest@example.com' # メールアドレスで機能を分けてる
      redirect_to root_path, notice: 'ゲストユーザーの登録情報は変更できません。'
    else
      @user = current_user
      if @user.update(user_params)
        flash[:notice] = 'ユーザー情報を更新しました。'
        redirect_to user_path
      else
        render :edit
      end
    end
  end

  def confirm
    @user = current_user
  end

  def withdraw
    if current_user.email == 'guest@example.com' # メールアドレスで機能を分けてる
      redirect_to root_path, notice: 'ゲストユーザーは退会できません。'
    else
      @user = current_user
      # is_activeカラムをtrueに変更することにより削除フラグを立てる
      @user.update(is_active: true)
      reset_session
      redirect_to root_path, notice: '退会処理を実行いたしました'
    end
  end

  def favorites
    @user = User.find(params[:id])
    favorite_ids = Favorite.where(user_id: @user.id)
                           .order(created_at: :desc) # いいねの日時で降順にソート
                           .pluck(:lifehack_id)
    @favorite_lifehacks = Lifehack.find(favorite_ids)
    @lifehacks = Lifehack.page(params[:page]).per(10)
                         .order(created_at: :desc)
                         .where(is_draft: false)
  end

  def index_user
    @user = User.find(params[:id])
    @lifehacks = Lifehack.where(user_id: params[:id])
                         .page(params[:page]).per(10)
                         .order(created_at: :desc)
                         .where(is_draft: false)
  end

  private

  def user_params
    params.require(:user).permit(:account_name, :profile_image, :introduction, :email)
  end

  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to users_path
    end
  end
end
