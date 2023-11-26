class Public::LifehacksController < ApplicationController
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]
  before_action :ensure_author_access, only: [:index_draft]
  def index
    @lifehacks = Lifehack.page(params[:page]).per(10)
                         .order(created_at: :desc)
                         .where(is_draft: false)
  end

  def show
    @lifehack = Lifehack.find(params[:id])
    @lifehack_comment = LifehackComment.new
    @lifehack_comments = @lifehack.lifehack_comments.order(created_at: :desc)

    # 下書きを作成したユーザーでない場合はリダイレクト
    if @lifehack.is_draft && @lifehack.user == current_user
      nil
    elsif @lifehack.is_draft
      redirect_to lifehacks_path
    end
  end

  def new
    @lifehack = Lifehack.new
  end

  def edit
    @lifehack = Lifehack.find(params[:id])
  end

  def create
    @lifehack = Lifehack.new
    @lifehack.user_id = current_user.id
    handle_lifehack_save
  end

  def update
    @lifehack = Lifehack.find(params[:id])
    handle_lifehack_save
  end

  def destroy
    @lifehack = Lifehack.find(params[:id])
    @lifehack.destroy
    redirect_to lifehacks_path
  end

  def index_draft
    @user = current_user
    @lifehacks = @user.lifehacks.where(is_draft: true)
                      .page(params[:page]).per(10)
                      .order(created_at: :desc)
  end

  private

  def lifehack_params
    params.require(:lifehack).permit(:title, :body, :star, :tag, lifehack_images: [])
  end

  def ensure_correct_user
    @lifehack = Lifehack.find(params[:id])
    return if @lifehack.user == current_user

    redirect_to lifehacks_path
  end

  def ensure_author_access
    redirect_to lifehacks_path unless current_user || admin_signed_in?
    return unless admin_signed_in?

    # admin がアクセスした場合は別のページにリダイレクト
    redirect_to admin_root_path
  end

  def handle_lifehack_save
    if params[:post]
      handle_save_and_redirect('ライフハックを投稿しました！', '投稿できませんでした。お手数ですが、入力内容をご確認のうえ再度お試しください')
    elsif params[:publicize_draft]
      handle_save_and_redirect('下書きのライフハックを公開しました！', 'ライフハックを公開できませんでした。お手数ですが、入力内容をご確認のうえ再度お試しください', true)
    elsif params[:update_post]
      handle_save_and_redirect('投稿内容を更新しました。', '更新できませんでした。お手数ですが、入力内容をご確認のうえ再度お試しください')
    else
      handle_save_and_redirect('下書きのライフハックを更新しました！', '更新できませんでした。お手数ですが、入力内容をご確認のうえ再度お試しください', true)
    end
  end

  def handle_save_and_redirect(success_message, failure_message, is_draft = false)
    if @lifehack.save_lifehack(lifehack_params, is_draft)
      redirect_to lifehack_path(@lifehack), notice: success_message
    else
      render :new, alert: failure_message
    end
  end
end
