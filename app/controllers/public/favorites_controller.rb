class Public::FavoritesController < ApplicationController
  def create
    lifehack = Lifehack.find(params[:lifehack_id])
    favorite = current_user.favorites.new(lifehack_id: lifehack.id)
    favorite.save
    redirect_to request.referer
  end

  def destroy
    lifehack = Lifehack.find(params[:lifehack_id])
    favorite = current_user.favorites.find_by(lifehack_id: lifehack.id)
    favorite.destroy
    redirect_to request.referer
  end
end
