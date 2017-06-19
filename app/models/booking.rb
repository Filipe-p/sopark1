class Booking < ApplicationRecord

  belongs_to :user
  belongs_to :space

  validates :user_id, :space_id, :start_datetime, :end_datetime, :cost presence: true
end