class SpaceOfferingsController < ApplicationController
  before_action :set_space_offering, only: [:show, :edit, :update, :destroy]
  before_action :set_space, only: [:new, :show, :create, :edit, :update, :destroy]

  def index
    @space_offerings = SpaceOffering.all
  end

  def show
  end

  def new
    @space_offering = SpaceOffering.new
  end

  def create
    @space_offering = SpaceOffering.new(space_offering_params)
    @space_offering.space = @space
    @space_offering.user = current_user
    if @space_offering.save
      redirect_to space_space_offering_path(@space, @space_offering)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @space_offering.update(space_offering_params)
      redirect_to space_space_offering_path(@space, @space_offering)
    else
      render :new
    end
  end

  def destroy
    @space_offering.destroy
    redirect_to space_space_offerings_path(@space)
  end

  private
  def set_space
    @space = Space.find(params[:space_id])
  end

  def set_space_offering
    @space_offering = SpaceOffering.find(params[:id])
  end

  def space_offering_params
    space_offering_params = params.require(:space_offering).permit(:start_datetime, :end_datetime, :price)

    space_offering_params[:start_datetime] = space_offering_params[:start_datetime].to_datetime
    space_offering_params[:end_datetime] = space_offering_params[:end_datetime].to_datetime

    space_offering_params
  end

end
