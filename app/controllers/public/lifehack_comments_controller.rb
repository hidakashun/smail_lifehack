class Public::LifehackCommentsController < ApplicationController
  def create
    lifehack = Lifehack.find(params[:lifehack_id])
    comment = current_user.lifehack_comments.new(lifehack_comment_params)
    comment.lifehack_id = lifehack.id
    comment.save
    redirect_to request.referer
  end

  def destroy
    LifehackComment.find_by(id: params[:id], lifehack_id: params[:lifehack_id]).destroy
    redirect_to request.referer
  end

  private
  def lifehack_comment_params
    params.require(:lifehack_comment).permit(:comment)
  end
end
