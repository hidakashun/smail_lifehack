class Admin::LifehacksController < ApplicationController
  def index
  end

  def show
     @lifehack = Lifehack.find(params[:id])
  end
end
