class SpacesController < ApplicationController
  before_action :set_space, only: [:show, :edit, :update, :destroy]
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    if params.has_key?(:search) && params[:search][:location] != ""
        @spaces = @spaces.where(location: params[:search][:location].capitalize)
    else
      @spaces = Space.all
    end

  end

  def show
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
