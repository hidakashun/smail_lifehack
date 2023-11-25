class Public::SearchesController < ApplicationController
  def search
    # フォームから送信された情報を受け取ります
    @model = params[:model] # 検索モデル（ユーザーまたはライフハック）
    @content = params[:keyword_content] # キーワード検索ワード
    @method = params[:method] # 検索方法

    @records = if @model == 'user'
                 # ユーザーモデルで検索を実行します
                 User.search_for(@content, @method)
                     .order(created_at: :desc)
                     .page(params[:page])
                     .per(10)
               else
                 # ライフハックモデルで検索を実行します
                 Lifehack.search_for(@content, @method)
                         .order(created_at: :desc)
                         .where(is_draft: false)
                         .page(params[:page])
                         .per(10)
               end
  end
end
