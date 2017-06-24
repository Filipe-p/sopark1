class Booking < ApplicationRecord

  belongs_to :user
  belongs_to :space

  validates :user_id, :space_id, :start_datetime, :end_datetime, :cost, presence: true

  monetize :cost_cents
end


#validate if booking date is overdue
#validate is booking dates are available
