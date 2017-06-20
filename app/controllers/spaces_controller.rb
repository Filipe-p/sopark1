class SpacesController < ApplicationController
  before_action :set_space, only: [:show, :edit, :update, :destroy]
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    if params.has_key?(:search) && params[:search][:location] != ""
        @spaces = Space.where(location: params[:search][:location].capitalize)
    else
      @spaces = Space.all
    end

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
  end

  def new
    @space = Space.new
  end

  def create
    @space = Space.new(space_params)
    @space.user = current_user
    if @space.save
      redirect_to space_path(@space)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @space.update(space_params)
      redirect_to space_path(@space)
    else
      render :new
    end
  end

  def destroy
    @space.destroy
    redirect_to spaces_path
  end

  private

  def set_space
    @space = Space.find(params[:id])
  end

  def space_params
    params.require(:space).permit(:name, :location, :user, :covered, :staff, :valet, :gate, :cctv, :charging, :water, :price)
  end

end
