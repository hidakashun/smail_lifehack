class Admin::HomesController < ApplicationController
  def top
    @lifehacks = Lifehack.page(params[:page]).per(10)
                         .order(created_at: :desc)
                         .where(is_draft: false)
  end
end
