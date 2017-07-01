class BookingDashboardsController < ApplicationController
  before_action :set_booking, only: [:show]

  def index
    @bookings = Booking.where(user: current_user)
  end

  def show

  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
  def set_booking
    @booking = Booking.find(params[:id])
  end
end
