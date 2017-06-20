class AddStripeChangeToBookings < ActiveRecord::Migration[5.0]
  def change
    add_column :bookings, :state, :string
    add_column :bookings, :payment, :json
    remove_column :bookings, :cost
    add_monetize :bookings, :cost, currency: {present: false}

  end
end
