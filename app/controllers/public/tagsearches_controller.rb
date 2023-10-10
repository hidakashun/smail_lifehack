class Public::TagsearchesController < ApplicationController
  def search
    @model = Lifehack  #search機能とは関係なし
    @word = params[:content]
    @lifehacks = Lifehack.where("tag LIKE?","%#{@word}%")
    render "public/tagsearches/tagsearch"
  end
end
