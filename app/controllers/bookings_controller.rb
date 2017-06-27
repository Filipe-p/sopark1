class BookingsController < ApplicationController
  before_action :set_booking, only: [:show, :edit, :update, :destroy]
  before_action :set_space, only: [:new, :show, :create, :edit, :update, :destroy]

  def index
    @bookings = Booking.all
  end

  def show
  end

  def new
    @booking = Booking.new

    # I need to unselect certain dates
    # @unavailable_dates = @space.unavailable_dates
  end

  def create
    @review = Review.new
    # redirect to confirmation
    @booking = Booking.new(booking_params)

    @booking.space = @space
    @booking.user_id = current_user.id

    if @booking.user == @space.user #User is owner
      @booking.state = 'reserved'
      if @booking.save
        redirect_to space_bookings_path(@space, @booking)
      else
        # render :new
        render 'spaces/show'
      end
    elsif @booking.user != @space.user #User is not owner
      @booking.state = 'pending'
      if @booking.save
        redirect_to new_space_booking_payment_path(@space, @booking)
      else
        # render :new
        render 'spaces/show'
      end
    end
  end

  def edit
  end

  def update

    if @booking.user == @space.user #User is owner
      if @booking.update(booking_params)
        redirect_to space_booking_path(@space, @booking)
      else
        render :new
      end
    elsif @booking.user != @space.user #User is not owner
      if @booking.update(booking_params)
        redirect_to space_booking_path(@space, @booking)
      else
        render :new
      end
    end

    # redirect to confirmation

  end

  def destroy
    @booking.destroy
    redirect_to space_bookings_path(@space)
  end

  private

  def set_space
    @space = Space.find(params[:space_id])
  end

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def booking_params
    booking_params = params.require(:booking).permit(:start_datetime, :end_datetime, :cost, :status)

    unless (booking_params[:start_datetime] == "" || booking_params[:end_datetime] == "")
      booking_params[:start_datetime] = booking_params[:start_datetime].to_date #time
      booking_params[:end_datetime] = booking_params[:end_datetime].to_date #time
      booking_params[:cost] = (booking_params[:end_datetime] - booking_params[:start_datetime] + 1).to_i * @space.price
    end
    booking_params
  end

end
