class Public::TagsearchesController < ApplicationController
  def search
    @model = Lifehack  #search機能とは関係なし
    @word = params[:content2]  # 検索ワード
    @lifehacks = Lifehack.where("tag LIKE?","%#{@word}%")
                         .page(params[:page]).per(10)
                         .where(is_draft: false)
                         .order(created_at: :desc)
    render "public/tagsearches/tagsearch"
  end
end
