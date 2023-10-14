class Public::SearchesController < ApplicationController

  def search
    #このコードで検索フォームからの情報を受け取っている。
    @model = params[:model]#検索モデル→params[:model]
    @content = params[:content]#検索ワード→params[:content]
    @method = params[:method]#検索方法→params[:method]
    @lifehacks = Lifehack.page(params[:page]).per(10).order(created_at: :desc)

    if @model == 'user'
      @records = User.search_for(@content, @method)
    else
      @records = Lifehack.search_for(@content, @method)
    end
  end

end
