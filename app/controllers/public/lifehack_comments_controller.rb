class Public::LifehackCommentsController < ApplicationController
  before_action :ensure_correct_user, only: [:destroy]

  def create
    lifehack = Lifehack.find(params[:lifehack_id])
    @comment = current_user.lifehack_comments.new(lifehack_comment_params)
    @comment.lifehack_id = lifehack.id
    @comment.score = Language.get_data(lifehack_comment_params[:comment])  # 自然言語処理
    @comment.save
    @lifehack = Lifehack.find(params[:lifehack_id])
    @lifehack_comments = @lifehack.lifehack_comments.order(created_at: :desc) # ライフハックに紐づいたライフハックのコメントの情報を取得
  end

  def destroy
    @comment = LifehackComment.find(params[:id])
    @comment.destroy
    @lifehack = Lifehack.find(params[:lifehack_id])
    @lifehack_comments = @lifehack.lifehack_comments.order(created_at: :desc) # ライフハックに紐づいたライフハックのコメントの情報を取得
  end

  private

  def lifehack_comment_params
    params.require(:lifehack_comment).permit(:comment)
  end

  def ensure_correct_user
    @comment = LifehackComment.find(params[:id])
    unless @comment.user == current_user || admin_signed_in?
      redirect_to lifehacks_path
    end
  end
end
