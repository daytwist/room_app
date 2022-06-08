class RoomsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  def home
    @q = Room.ransack(params[:id])
    @rooms = @q.result(distinct: true)
  end

  def search
    @q = Room.search(search_params)
    @rooms = @q.result(distinct: true).with_attached_image
  end

  def new
    @room = Room.new
  end

  def create
    @room = Room.new(room_params)
    if @room.save
      flash[:notice] = "ルームを新規登録しました"
      redirect_to "/users/#{current_user.id}/posts"
    else
      flash.now[:alert] = "ルームを登録できませんでした"
      render "new"
    end
  end

  def show
    @room = Room.find(params[:id])
    @reservation = Reservation.new
  end

  def edit
    @room = Room.find(params[:id])
  end

  def update
    @room = Room.find(params[:id])
    if @room.update(room_params)
      flash[:notice] = "ルーム情報を更新しました"
      redirect_to "/users/#{current_user.id}/posts"
    else
      flash.now[:alert] = "ルーム情報を更新できませんでした"
      render "edit"
    end
  end

  def destroy
    @room = Room.find(params[:id])
    @room.destroy
    flash[:notice] = "ルームを削除しました"
    redirect_to "/users/#{current_user.id}/posts"
  end

  private
  def search_params
    params.require(:q).permit(:address_cont, :name_or_address_or_introduction_cont)
  end

  def room_params
    params.require(:room).permit(:name, :address, :price_per_day, :introduction, :image, :user_id)
  end
end
