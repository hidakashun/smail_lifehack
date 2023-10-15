class Public::HomesController < ApplicationController
  def top
    @lifehacks = Lifehack.order(created_at: :desc)
                         .limit(4)
                         .where(is_draft: false)
  end

  def about
  end
end
