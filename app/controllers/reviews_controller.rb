class ReviewsController < ApplicationController
  before_action :set_space

  def index
  end

  def show
  end

  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @review.space = @space
    @review.user = current_user

    # Here because the spaces show needs to be rendered and it uses a new booking instance
    @booking = Booking.new

    if @review.save
      redirect_to space_path(@space)
    else
      render 'spaces/show'
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
  def set_space
    @space = Space.find(params[:space_id])
  end

  def review_params
    params.require(:review).permit(:content, :rating)
  end
end
