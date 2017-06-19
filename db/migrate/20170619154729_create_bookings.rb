class CreateBookings < ActiveRecord::Migration[5.0]
  def change
    create_table :bookings do |t|
      t.references :user, foreign_key: true
      t.references :space, foreign_key: true
      t.date :start_datetime
      t.date :end_datetime
      t.float :cost

      t.timestamps
    end
  end
end
