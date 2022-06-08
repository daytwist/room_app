class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update, :account, :posts, :reservations]

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "プロフィールを更新しました"
      redirect_to user_path
    else
      flash.now[:alert] = "プロフィールを更新出来ませんでした"
      render "edit"
    end
  end

  def account
    @user = User.find(params[:id])
  end

  def posts
    @user = User.find(params[:id])
    @rooms = @user.rooms.with_attached_image
  end

  def reservations
    @user = User.find(params[:id])
    @reservations = @user.reservations.includes(:room)
  end

  private
  def user_params
    params.require(:user).permit(:name, :introduction, :image)
  end
end
