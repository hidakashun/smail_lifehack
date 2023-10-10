class Public::LifehacksController < ApplicationController
  def new
    @lifehack = Lifehack.new
  end

  def index
    @lifehacks = Lifehack.all
  end

  def show
    @lifehack = Lifehack.find(params[:id])
    @lifehack_comment = LifehackComment.new
  end

  def edit
    @lifehack = Lifehack.find(params[:id])
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
    @lifehack = Lifehack.find(params[:id])
    @lifehack.destroy
    redirect_to lifehacks_path
  end

  def update
    @lifehack = Lifehack.find(params[:id])
    if @lifehack.update(lifehack_params)
      redirect_to lifehack_path(@lifehack), notice: "変更しました。"
    else
      render :edit
    end
  end
private

  def lifehack_params
    params.require(:lifehack).permit(:title, :body, :star, :tag, lifehack_images: [])
  end
end
