class Space < ApplicationRecord
  belongs_to :user

  validates :name, :location, :user_id, :price, presence: true

  geocoded_by :location
  after_validation :geocode, if: :location_changed?

  has_many :reviews, dependent: :destroy
  has_many :space_offerings, dependent: :destroy
  has_many :bookings, dependent: :destroy

  has_attachment :photo

  monetize :price_cents

  def rating
    self.reviews.empty? ? 0 : self.reviews.average(:rating).round
  end

  # See if space offering is past date
  # Select the availability
  # Check if dates are available

  def available
    result = []
    self.space_offerings.each do |offering|
      supply = (offering.start_datetime..offering.start_datetime).to_a
      result << suppy
    end
    result = result.uniq # to prevent space offerings from overlapping -- should be changed in space offerings to prevent submission
    self.bookings.each do |booking|
      demand = (booking.start_datetime..booking.start_datetime).to_a
      result = result - demand
    end
    result
  end

  def booking_dates
    result = []
    self.bookings.each do |booking|
      demand = (booking.start_datetime..booking.end_datetime).to_a
      result += demand
    end
    result = result.uniq # to prevent space offerings from overlapping -- should be changed in space offerings to prevent submission
    result.sort
  end

  def offering_dates
    result = []
    self.space_offerings.each do |offering|
      supply = (offering.start_datetime..offering.end_datetime).to_a
      result += supply
    end
    result = result.uniq # to prevent space offerings from overlapping -- should be changed in space offerings to prevent submission
    result.sort
  end

  def available_dates
    (offering_dates - booking_dates).sort
  end

  def available?(booking)
    desired_dates = (booking.start_datetime..booking.end_datetime).to_a
    (desired_dates - available_dates) == desired_dates
  end

  def end_date
    self.offering_dates[-1]
  end

  def start_date
    self.offering_dates[0]
  end

  def reserved_dates
    ((self.start_date..self.end_date).to_a - offering_dates)).sort
  end

  def unavailable_dates
    (booking_dates + reserved_dates).uniq.sort
  end
end
