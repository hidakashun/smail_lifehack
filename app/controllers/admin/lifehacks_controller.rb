class Admin::LifehacksController < ApplicationController
  def index
  end

  def show
     @lifehack = Lifehack.find(params[:id])
  end

  def destroy
    @lifehack = Lifehack.find(params[:id])
    @lifehack.destroy
    redirect_to admin_root_path, notice: "管理者権限により投稿を削除しました。"
  end
end
