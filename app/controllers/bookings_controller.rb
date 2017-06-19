class BookingsController < ApplicationController
  before_action :set_booking, only: [:show, :edit, :update, :destroy]
  before_action :set_space, only: [:show, :edit, :update, :destroy]

  def index
    @bookings = Booking.all
  end

  def show
  end

  def new
    @booking = Booking.new
  end

  def create

    # redirect to confirmation
    @booking = @space.bookings.build(booking_params)

    if @booking.save
      redirect_to space_booking_path(@space)
    else
      render :new
    end
  end

  def edit
  end

  def update

    # redirect to confirmation
    if @booking.update(booking_params)
      redirect_to space_booking_path(@booking)
    else
      render :new
    end
  end

  def destroy
    @booking.destroy
    redirect_to space_bookings_path
  end

  private

  def set_space
    @space = Space.find(params[:space_id])
  end

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def booking_params
    booking_params = params.require(:booking).permit(:start_date, :end_date, :cost, :status)

    booking_params[:start_date] = Date.parse(booking_params[:start_date])
    booking_params[:end_date] = Date.parse(booking_params[:end_date])

    booking_params
  end
end
