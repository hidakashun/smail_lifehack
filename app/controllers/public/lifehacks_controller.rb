class Public::LifehacksController < ApplicationController
  def new
    @lifehack = Lifehack.new
  end

  def index
    @lifehacks = Lifehack.page(params[:page]).per(10)
                         .order(created_at: :desc)
                         .where(is_draft: false)
  end

  def show
    @lifehack = Lifehack.find(params[:id])
    @lifehack_comment = LifehackComment.new
    @lifehack_comments = @lifehack.lifehack_comments.order(created_at: :desc)#ライフハックに紐づいたライフハックのコメントの情報を取得
  end

  def edit
    @lifehack = Lifehack.find(params[:id])
  end

  def create
    @lifehack = Lifehack.new(lifehack_params)

    @lifehack.user_id = current_user.id
    # 投稿ボタンを押下した場合
    if params[:post]
      if @lifehack.save(context: :publicize)
        redirect_to lifehack_path(@lifehack), notice: "ライフハックを投稿しました！"
      else
        render :new,alert: "投稿できませんでした。お手数ですが、入力内容をご確認のうえ再度お試しください"
      end
    # 下書きボタンを押下した場合
    else
      @lifehack.is_draft = true
      if @lifehack.save(context: :publicize)
        redirect_to lifehack_path(@lifehack), notice: "ライフハックを下書き保存しました！"
      else
        render :new, alert: "登録できませんでした。お手数ですが、入力内容をご確認のうえ再度お試しください"
      end
    end
  end

  def destroy
    @lifehack = Lifehack.find(params[:id])
    @lifehack.destroy
    redirect_to lifehacks_path
  end

  def update
    @lifehack = Lifehack.find(params[:id])
    @lifehack.score = Language.get_data(lifehack_params[:body])  #自然言語処理
    # 下書きライフハックの更新（公開）の場合
    if params[:publicize_draft]
      # ライフハック公開時にバリデーションを実施
      # updateメソッドにはcontextが使用できないため、公開処理にはattributesとsaveメソッドを使用する
      @lifehack.attributes = lifehack_params.merge(is_draft: false)
      if @lifehack.save(context: :publicize)
        redirect_to lifehack_path(@lifehack), notice: "下書きのライフハックを公開しました！"
      else
        @lifehack.is_draft = true
          render :edit, alert: "ライフハックを公開できませんでした。お手数ですが、入力内容をご確認のうえ再度お試しください"
      end
    # 公開済みライフハックの更新の場合
    elsif params[:update_post]
       @lifehack.attributes = lifehack_params
      if @lifehack.save(context: :publicize)
        redirect_to lifehack_path(@lifehack), notice: "投稿内容を更新しました。"
      else
        render :edit,alert: "更新できませんでした。お手数ですが、入力内容をご確認のうえ再度お試しください"
      end
    # 下書きライフハックの更新（非公開）の場合
    else
      if @lifehack.update(lifehack_params)
        redirect_to lifehack_path(@lifehack), notice: "下書きのライフハックを更新しました！"
      else
        render :edit, alert: "更新できませんでした。お手数ですが、入力内容をご確認のうえ再度お試しください"
      end
    end
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
end
