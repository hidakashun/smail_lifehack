class Admin::HomesController < ApplicationController
  def top
    @lifehacks = Lifehack.all
  end
end
