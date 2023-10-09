class Public::UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def index
    @users = User.all
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = current_user
    if @user.update(user_params)
      flash[:notice] = "ユーザー情報を更新しました。"
      redirect_to users_path
    else
      @user = current_user
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
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:account_name,:profile_image,:introduction,:email,)
  end
end
