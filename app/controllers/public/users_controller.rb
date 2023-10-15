class Public::UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def index
    @users = User.page(params[:page]).per(10)
                 .order(created_at: :desc)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = current_user
    if @user.update(user_params)
      flash[:notice] = "ユーザー情報を更新しました。"
      redirect_to user_path
    else
      render :edit
    end
  end

  def confirm
  end

  def withdraw
    @user = current_user
    # is_activeカラムをtrueに変更することにより削除フラグを立てる
    @user.update(is_active: true)
    reset_session
    redirect_to root_path, notice: "退会処理を実行いたしました"
  end

  def favorites
    @user = User.find(params[:id])
    favorites = Favorite.where(user_id: @user.id).pluck(:lifehack_id)
    @favorite_lifehacks = Lifehack.find(favorites)
    @lifehacks = Lifehack.page(params[:page]).per(10)
  end

  def index_user
    @user = User.find(params[:id])
    @lifehacks = Lifehack.where(user_id:params[:id])
                         .page(params[:page]).per(10)
                         .order(created_at: :desc)
                         .where(is_draft: false)
  end

  private

  def user_params
    params.require(:user).permit(:account_name,:profile_image,:introduction,:email,)
  end

end
