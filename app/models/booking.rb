class Booking < ApplicationRecord

  belongs_to :user
  belongs_to :space

  validates :user, :space, :start_datetime, :end_datetime, :cost, presence: true

  monetize :cost_cents


  validate do |booking|
    unless booking.space.available?(booking)
      errors.add(:start_datetime, "Not available at specified dates")
      errors.add(:end_datetime, "Not available at specified dates")
    end

    unless booking.start_datetime <= booking.end_datetime
      errors.add(:start_datetime, "End date must be higher or equal than start date")
      errors.add(:end_datetime, "End date must be higher or equal than start date")
    end
  end
end


#validate if booking date is overdue
#validate is booking dates are available
