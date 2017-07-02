class SpacesController < ApplicationController
  before_action :set_space, only: [:show, :edit, :update, :destroy]
  skip_before_action :authenticate_user!, only: [:show]

  def index

    @spaces = Space.all


     # @spaces = @spaces.where.not(latitude: nil, longitude: nil)

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
    #Just here because of the booking form
    @booking = Booking.new
    #Just here because of the review form
    @review = Review.new

    # Just here to pass the available dates to the date picker
    # @unavailable_dates = @space.unavailable_dates
  end

  def new
    @space = Space.new
  end

  def create
    @space = Space.new(space_params)
    @space.user = current_user
    if @space.save
      redirect_to space_path(@space) # I need to redirect the user to the dashboard IMPORTANT!
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @space.update(space_params)
      redirect_to space_path(@space) # I need to redirect the user to the dashboard IMPORTANT!
    else
      render :new
    end
  end

  def destroy
    @space.destroy
    redirect_to spaces_path  # I need to redirect the user to the dashboard IMPORTANT!
  end


  private

  def set_space
    @space = Space.find(params[:id])
  end

  def space_params
    space_params = params.require(:space).permit(:name, :location, :covered, :staff, :valet, :gate, :cctv, :charging, :water, :price, :photo, :price_cents, :price, :country, :zip_code, :house_number, :street, :city_town, :photo)
    space_params
  end

end
