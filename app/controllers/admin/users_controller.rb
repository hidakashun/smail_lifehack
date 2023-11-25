class Admin::UsersController < ApplicationController
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
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = '会員情報を更新しました'
      redirect_to admin_user_path(@user)
    else
      render :edit
    end
  end

  def favorites
    @user = User.find(params[:id])
    favorite_ids = Favorite.where(user_id: @user.id)
                           .order(created_at: :desc) # いいねの日時で降順にソート
                           .pluck(:lifehack_id)
    @favorite_lifehacks = Lifehack.where(id: favorite_ids)
                                  .page(params[:page]).per(10)
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
    params.require(:user).permit(:is_active)
  end
end
