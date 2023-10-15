class Public::LifehackCommentsController < ApplicationController
  def create
    lifehack = Lifehack.find(params[:lifehack_id])
    @comment = current_user.lifehack_comments.new(lifehack_comment_params)
    @comment.lifehack_id = lifehack.id
    @comment.save
    redirect_to request.referer
  end

  def destroy
    @comment = LifehackComment.find(params[:id])
    @comment.destroy
  end

  private
  def lifehack_comment_params
    params.require(:lifehack_comment).permit(:comment)
  end
end
