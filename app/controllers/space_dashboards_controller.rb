class SpaceDashboardsController < ApplicationController
  before_action :set_space, only: [:show]
  def index
    @spaces = Space.where(user: current_user)

    @spaces = @spaces.where.not(latitude: nil, longitude: nil)

    @hash = Gmaps4rails.build_markers(@spaces) do |space, marker|
      marker.lat space.latitude
      marker.lng space.longitude
      #marker.infowindow render_to_string(partial: "/flats/map_box", locals: { flat: flat })
    end
  end

  def show
    @hash = Gmaps4rails.build_markers(@space) do |space, marker|
      marker.lat space.latitude
      marker.lng space.longitude
      #marker.infowindow render_to_string(partial: "/flats/map_box", locals: { flat: flat })
    end
    #Just here because of the booking form for blocking dates
    # if there is not a booking created do this
    @booking = Booking.new
    # if there is a booking created, change that booking state (to canceled) and create a new one (reserved)

    # Maybe owners can rate and review users that booked one of their garage?
    #Just here because of the review form
    # @review = Review.new

    # Just here to pass the available dates to the date picker
    # @unavailable_dates = @space.unavailable_dates
  end

  private
  def set_space
    @space = Space.find(params[:id])
  end
end
