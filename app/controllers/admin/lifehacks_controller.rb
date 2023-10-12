class Admin::LifehacksController < ApplicationController
  def index
  end

  def show
     @lifehack = Lifehack.find(params[:id])
  end

  def destroy
    @lifehack = Lifehack.find(params[:id])
    @lifehack.destroy
    redirect_to admin_root_path
  end
end
