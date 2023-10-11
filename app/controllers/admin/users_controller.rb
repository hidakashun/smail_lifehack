class Admin::UsersController < ApplicationController
  def index
   @user = User.page(params[:page]).per(10)
  end

  def show
    @user = User.find(params[:id])
  end
end
