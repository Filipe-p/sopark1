class PaymentMailer < ApplicationMailer
  def payment_confirmation(space, booking)
    @space = space
    @booking = booking

    mail(
      to:       @booking.user.email,
      subject:  "Booking confirmation of #{@space.name}!"
    )
  end
end
