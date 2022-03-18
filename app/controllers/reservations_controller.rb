class ReservationsController < ApplicationController
  def new
    @reservation = Reservation.new
  end

  def create
    @reservation = Reservation.new(reservation_params)
    @room = @reservation.room
    if @reservation.save
      flash[:notice] = 'ルームを予約しました'
      redirect_to "/users/#{current_user.id}/reservations"
    else
      flash.now[:alert] = 'ルームを予約できませんでした'
      render 'rooms/show'
    end
  end

  def edit
    @reservation = Reservation.find(params[:id])
    @room = @reservation.room
  end

  def update
    @reservation = Reservation.find(params[:id])
    @room = @reservation.room
    if @reservation.update(reservation_params)
      flash[:notice] = '予約変更を受け付けました'
      redirect_to "/users/#{current_user.id}/reservations"
    else
      flash.now[:alert] = '予約変更できませんでした'
      render 'edit'
    end
  end

  def destroy
    @reservation = Reservation.find(params[:id])
    @reservation.destroy
    flash[:notice] = '予約をキャンセルしました'
    redirect_to "/users/#{current_user.id}/reservations"
  end

  private

  def reservation_params
    params.require(:reservation).permit(:user_id, :room_id, :start_date, :end_date, :num_of_people)
  end
end
