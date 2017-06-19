class CreateBookings < ActiveRecord::Migration[5.0]
  def change
    create_table :bookings do |t|
      t.references :user, foreign_key: true
      t.integer :car_id
      t.references :space_id, foreign_key: true
      t.datetime :start_datetime
      t.datetime :end_datetime
      t.float :cost

      t.timestamps
    end
  end
end
