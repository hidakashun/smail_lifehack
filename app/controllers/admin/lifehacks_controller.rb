class Admin::LifehacksController < ApplicationController
  def show
    @lifehack = Lifehack.find(params[:id])
    @lifehack_comments = @lifehack.lifehack_comments.order(created_at: :desc)
  end

  def destroy
    @lifehack = Lifehack.find(params[:id])
    @lifehack.destroy
    redirect_to admin_root_path, notice: '管理者権限により投稿を削除しました。'
  end
end
