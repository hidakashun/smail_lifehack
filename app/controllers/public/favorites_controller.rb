class Public::FavoritesController < ApplicationController
  def create
    lifehack = Lifehack.find(params[:lifehack_id])
    # 通知機能
    lifehack.create_notification_favorite_lifehack!(current_user) if current_user != lifehack.user
    @favorite = current_user.favorites.new(lifehack_id: lifehack.id)
    @favorite.save
    render 'replace_btn'
  end

  def destroy
    lifehack = Lifehack.find(params[:lifehack_id])
    @favorite = current_user.favorites.find_by(lifehack_id: lifehack.id)
    @favorite.destroy
    render 'replace_btn'
  end
end
