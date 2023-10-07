class Public::LifehacksController < ApplicationController
  def new
    @lifehack = Lifehack.new
  end

  def index
    @lifehacks = Lifehack.all
  end

  def show
  end

  def edit
  end

  def create
    @lifehack = Lifehack.new(lifehack_params)
    @lifehack.user_id = current_user.id
    if @lifehack.save
      redirect_to lifehack_path(@lifehack), notice: "投稿しました。"
    else
      render :new
    end
  end

  def destroy
  end

  def update
  end
private

  def lifehack_params
    params.require(:lifehack).permit(:title, :body, :lifehack_image)
  end
end
