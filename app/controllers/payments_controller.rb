class PaymentsController < ApplicationController
  before_action :set_booking, :set_space

  def new
  end

  def create
    customer = Stripe::Customer.create(
      source: params[:stripeToken],
      email:  params[:stripeEmail]
    )

    charge = Stripe::Charge.create(
      customer:     customer.id,   # You should store this customer id and re-use it.
      amount:       @booking.cost_cents, # or amount_pennies
      description:  "Payment for space #{@space.name} at soparque.pt",
      currency:     @booking.cost.currency
    )

    @booking.update(payment: charge.to_json, state: 'paid')
    PaymentMailer.payment_confirmation(@space, @booking).deliver_now
    redirect_to space_booking_path(@space, @booking)

  rescue Stripe::CardError => e
    flash[:alert] = e.message
    redirect_to new_space_booking_payment_path(@space, @booking)
  end

  private

    def set_booking
      @booking = Booking.where(state: 'pending').find(params[:booking_id])
    end

    def set_space
      @space = Space.find(params[:space_id])
    end
end
